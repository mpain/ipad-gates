#import "GTSNumberCell.h"
#import "GTSNumberElement.h"

@implementation GTSNumberCell {
    __strong NSNumberFormatter *formatter;
}

- (void)awakeFromNib {
    formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
}

- (void)updateCellForElement:(GTSRowElement *)element andTableView:(GTSFormTableView *)aTableView {
    [super updateCellForElement:element andTableView:aTableView];
    [self updateTextValueFromElement];
}

- (GTSNumberElement *)numberElement {
    return (GTSNumberElement *)self.element;
}

- (void)updateFormatter {
    formatter.minimumFractionDigits = [self numberElement].fractionDigits;
    formatter.maximumFractionDigits = [self numberElement].fractionDigits;
}

- (void)updateTextValueFromElement {
    [self updateFormatter];
    self.textValue.text = [formatter stringFromNumber:[self numberElement].number];
}

- (void)updateElementFromTextValue:(NSString *)value {
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i< [value length]; i++) {
        unichar current = [value characterAtIndex:i];
        NSString *charStr = [NSString stringWithCharacters:&current length:1];
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:current]) {
            [result appendString:charStr];
        }
    }
    
    [self updateFormatter];
    NSNumber *parsed = [formatter numberFromString:result];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithMantissa:[parsed unsignedLongLongValue] exponent:-[self numberElement].fractionDigits isNegative:NO];
    [self numberElement].number = number;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacement {
    [super textField:textField shouldChangeCharactersInRange:range replacementString:replacement];
    
    NSString *newValue = [textField.text stringByReplacingCharactersInRange:range withString:replacement];
    [self updateElementFromTextValue:newValue];
    [self updateTextValueFromElement];
    
    return NO;
}
@end
