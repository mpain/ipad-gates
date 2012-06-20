#import "GTSCalculatorBrains.h"

@implementation GTSCalculatorBrains {
	__strong NSString *_waitingOperation;
	__strong NSDecimalNumber *_waitingOperand;
	__strong NSDecimalNumber *_savedOperand;
}

@synthesize error = _error;
@synthesize operand = _operand;

- (void)performWaitingOperation {
	if ([@"+" isEqual:_waitingOperation]) {
		_operand = [_waitingOperand decimalNumberByAdding:_operand];
	} else if ([@"-" isEqual:_waitingOperation]) {
		_operand = [_waitingOperand decimalNumberBySubtracting:_operand];
	} else if ([@"*" isEqual:_waitingOperation]) {
		_operand = [_waitingOperand decimalNumberByMultiplyingBy:_operand];
	} else if ([@"/" isEqual:_waitingOperation]) {
		if ([_operand compare:NSDecimalNumber.zero] != NSOrderedSame) {
			_operand = [_waitingOperand decimalNumberByDividingBy:_operand];
		} else {
			_error = @"Divide by zero";
		}
	}
}

- (NSDecimalNumber *)performOperation:(NSString *)operation {
	if (!operation) {
		return _operand;
	}
	
    if ([operation isEqual:@"C"]) {
		_waitingOperation = nil;
		_waitingOperand = NSDecimalNumber.zero;
		_operand = NSDecimalNumber.zero;
		_savedOperand = NSDecimalNumber.zero;
	} 
	
	if ([operation isEqual:@"sqrt"]) {
		if (_operand >= 0) {
			_operand = [self sqrt:_operand];
		} else {
			_error = @"Square root of a negative number";
			_operand = [NSDecimalNumber notANumber];
		}
	} else if ([operation isEqual:@"+/-"]) {
		_operand = [_operand decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
	} else if ([operation isEqual:@"1/x"]) {
		if (_operand) {
			_operand = [NSDecimalNumber.one decimalNumberByDividingBy:_operand];
		} else {
			_error = @"Divide by zero";
			_operand = [NSDecimalNumber notANumber];
		}
	} else if ([operation isEqual:@"MC"]) {
		_savedOperand = NSDecimalNumber.zero;
	} else if ([operation isEqual:@"MR"]) {
		_operand = [_savedOperand copy];
	} else if ([operation isEqual:@"M+"]) {
		_savedOperand = [_operand decimalNumberByAdding:_savedOperand];
	} else {
		[self performWaitingOperation];
		_waitingOperation = operation;
		_waitingOperand = _operand;
	}
	
	return _operand;
}

- (NSDecimalNumber *)sqrt:(NSDecimalNumber *)source {
    if ([source compare:[NSDecimalNumber zero]] == NSOrderedAscending) {
        return [NSDecimalNumber notANumber];
    }
	
    NSDecimalNumber *half =	[NSDecimalNumber decimalNumberWithMantissa:5 exponent:-1 isNegative:NO];
    NSDecimalNumber *guess = [[source decimalNumberByAdding:[NSDecimalNumber one]] decimalNumberByMultiplyingBy:half];
	
    @try
    {
        const int NUM_ITERATIONS_TO_CONVERGENCE = 6;
        for (int i = 0; i < NUM_ITERATIONS_TO_CONVERGENCE; i++) {
            guess = [[[source decimalNumberByDividingBy:guess] decimalNumberByAdding:guess] decimalNumberByMultiplyingBy:half];
        }
    } @catch (NSException *exception) {
    }
	
    return guess;
}
@end
