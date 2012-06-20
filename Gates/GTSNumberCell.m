#import "GTSNumberCell.h"
#import "GTSNumberElement.h"
#import "GTSCalculatorViewController.h"

@implementation GTSNumberCell {
    __strong NSNumberFormatter *_formatter;
	__strong UIPopoverController *_popover;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    _formatter = [NSNumberFormatter new];
    _formatter.numberStyle = NSNumberFormatterDecimalStyle;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideCalculator:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideCalculator:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideCalculator:) name:UIDeviceOrientationDidChangeNotification object:nil];	
}

- (GTSNumberElement *)numberElement {
    return (GTSNumberElement *)self.element;
}

- (void)updateFormatter {
	_formatter.maximumIntegerDigits = 8;
	_formatter.usesGroupingSeparator = NO;
    _formatter.minimumFractionDigits = 0;
    _formatter.maximumFractionDigits = [self numberElement].fractionDigits;
}

- (void)updateCellFromElement {
    [self updateFormatter];
    self.textValue.text = [[self numberElement].number description];//[_formatter stringFromNumber:[self numberElement].number];
}

- (NSString *)numberFromTextValue:(NSString *)value {
//	NSMutableString *result = [[NSMutableString alloc] init];
//    for (NSUInteger i = 0; i< [value length]; i++) {
//        unichar current = [value characterAtIndex:i];
//        NSString *charStr = [NSString stringWithCharacters:&current length:1];
//        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:current]) {
//            [result appendString:charStr];
//        }
//    }
//	
//	return result.length > 0 ? result : @"0";
	return value;
}

- (void)updateElementFromTextValue:(NSString *)value {
    [self updateFormatter];
    NSNumber *parsed = [_formatter numberFromString:[self numberFromTextValue:value]];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithMantissa:[parsed unsignedLongLongValue] exponent:-[self numberElement].fractionDigits isNegative:NO];
    [self numberElement].number = number;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacement { 
    NSString *newValue = [textField.text stringByReplacingCharactersInRange:range withString:replacement];
    [self updateElementFromTextValue:newValue];
    [self updateCellFromElement];
    
	[super textField:textField shouldChangeCharactersInRange:range replacementString:replacement];
    return NO;
}

- (IBAction)didCalculatorButtonTouch:(UIButton *)sender {
	if (_popover) {
		[self hideCalculator:nil];
	}
	
	GTSCalculatorViewController *content = [[GTSCalculatorViewController alloc] initWithNibName:@"CalculatorView" bundle:[NSBundle mainBundle]];
	content.delegate = self;
	content.initialOperand = [self numberFromTextValue:self.textValue.text];
	
	CGSize size = content.view.bounds.size;
	_popover = [[UIPopoverController alloc] initWithContentViewController:content];
	_popover.popoverContentSize = size;
	_popover.delegate = self;
	
	CGRect frame = [self convertRect:sender.frame toView:self.superview];
	[_popover presentPopoverFromRect:frame inView:[self superview] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)hideCalculator:(NSNotification *)notification {
	if (self.superview && _popover) {
		[_popover dismissPopoverAnimated:YES];
	}
	_popover = nil;
}

- (void)calculatorViewController:(GTSCalculatorViewController *)controller didEnterTouchWithResult:(NSString *)result {
	[self textField:self.textValue shouldChangeCharactersInRange:NSMakeRange(0, self.textValue.text.length) replacementString:result];
	[self hideCalculator:nil];
}
@end
