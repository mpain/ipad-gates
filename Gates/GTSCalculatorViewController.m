#import "GTSCalculatorViewController.h"
#import "GTSCalculatorBrains.h"

@implementation GTSCalculatorViewController {
	__strong GTSCalculatorBrains *_brains;
	BOOL _isUserTyping;
}

@synthesize display = _display;
@synthesize delegate = _delegate;
@synthesize initialOperand = _initialOperand;

- (id)init {
	self = [super init];
	if (self) {
		[self createBrains];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self createBrains];
	}
	return self;
}

- (void)createBrains {
	_brains = [GTSCalculatorBrains new];
}

- (void)viewDidLoad {
	if (_initialOperand) {
		_display.text = _initialOperand;
		_isUserTyping = YES;
		[self performOperation:@"="];
	}
}

- (IBAction)decimalPointPressed:(UIButton *)sender {
	NSRange range = [_display.text rangeOfString:@"."];
	
	if (_isUserTyping) {
		if (range.location == NSNotFound) {
			_display.text = [_display.text stringByAppendingString:@"."];
		}
	} else {
		_display.text = @"0.";
		_isUserTyping = YES;
	}
}

- (IBAction)didNumberButtonClick:(UIButton *)sender {
	NSString *digit = sender.titleLabel.text;
	
	if (_isUserTyping) {
		_display.text = [_display.text stringByAppendingString:digit];
	} else {
		_display.text = digit;
		_isUserTyping = YES;
	}
}

- (void)performOperation:(NSString *)operation {
    if (_isUserTyping) {
		_brains.operand = [NSDecimalNumber decimalNumberWithString:_display.text];
		_isUserTyping = NO;
	}
	
	NSDecimalNumber *result = [_brains performOperation:operation];
	_display.text = [result description];
}

- (IBAction)didOperationButtonClick:(UIButton *)sender {
	NSString *operation = sender.titleLabel.text;
	BOOL isEnterTouched = [operation isEqualToString:@"Enter"];
	
	if (isEnterTouched) {
		operation = @"=";
	}
	
	[self performOperation:operation];
	
	NSString *error = _brains.error;
	if (error) {
	} else if (isEnterTouched && [self.delegate respondsToSelector:@selector(calculatorViewController:didEnterTouchWithResult:)]) {
		[self.delegate calculatorViewController:self didEnterTouchWithResult:_display.text];
	}
}
@end
