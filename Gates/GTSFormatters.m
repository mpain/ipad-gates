#import "GTSFormatters.h"

#define FORMATTER_FRACTION_DIGITS_TWO 2
#define FORMATTER_FRACTION_DIGITS_FOUR 4
#define FORMATTER_POSITIVE_PREFIX @"+ "
#define FORMATTER_NEGATIVE_PREFIX @"- "
#define FORMATTER_DECIMAL_SEPARATOR @","
#define FORMATTER_GROUPING_SEPARATOR @" "

@implementation GTSFormatters

@synthesize floatNumberFormatter;

+ (GTSFormatters *)sharedInstance {
    static dispatch_once_t once;
    __strong static id _sharedInstance = nil;
    dispatch_once(&once, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (id) init {
	self = [super init];
	if (self ) {
		floatNumberFormatter = [[NSNumberFormatter alloc] init];
		floatNumberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
		floatNumberFormatter.minimumFractionDigits = FORMATTER_FRACTION_DIGITS_TWO;
		floatNumberFormatter.maximumFractionDigits = FORMATTER_FRACTION_DIGITS_FOUR;
		//floatNumberFormatter.positivePrefix = FORMATTER_POSITIVE_PREFIX;
		//floatNumberFormatter.negativePrefix = FORMATTER_NEGATIVE_PREFIX;
		floatNumberFormatter.decimalSeparator = FORMATTER_DECIMAL_SEPARATOR;
		floatNumberFormatter.groupingSeparator = FORMATTER_GROUPING_SEPARATOR;
		
	}
	return self;
}
@end
