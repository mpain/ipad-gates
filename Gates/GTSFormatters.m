#import "GTSFormatters.h"

#define FORMATTER_FRACTION_DIGITS_TWO 2
#define FORMATTER_FRACTION_DIGITS_FOUR 4
#define FORMATTER_POSITIVE_PREFIX @"+ "
#define FORMATTER_NEGATIVE_PREFIX @"- "
#define FORMATTER_DECIMAL_SEPARATOR @","
#define FORMATTER_GROUPING_SEPARATOR @" "

#define FORMATTER_DATETIME_FORMAT @"yyyy-MM-dd HH:mm"

@implementation GTSFormatters

@synthesize floatNumberFormatter;
@synthesize dateFormatter;

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
		
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:FORMATTER_DATETIME_FORMAT];
	}
	return self;
}
@end
