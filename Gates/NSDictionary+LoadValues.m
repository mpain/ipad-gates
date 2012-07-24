#import "NSDictionary+LoadValues.h"
#import "GTSAppDelegate.h"


@implementation NSDictionary (LoadValues)

- (NSInteger)integerWithKey:(NSString *)key {
    NSNumber *number = [self objectForKey:key];
    return number ? [number integerValue] : 0;
}

- (NSDecimalNumber *)decimalNumberWithKey:(NSString *)key {
	NSNumber *number = [self objectForKey:key];
	return number ? [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]] : nil;
}

- (NSString *)stringWithKey:(NSString *)key {
	return [self objectForKey:key];
}

- (NSDate *)dateWithKey:(NSString *)key {
    NSString *date = [self objectForKey:key];
    return date ? [ServiceLocator.formatters.dateFormatter dateFromString:date] : nil;
}

@end
