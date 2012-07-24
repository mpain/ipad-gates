#import <Foundation/Foundation.h>

@interface NSDictionary (LoadValues)

- (NSInteger)integerWithKey:(NSString *)key;
- (NSDecimalNumber *)decimalNumberWithKey:(NSString *)key;
- (NSString *)stringWithKey:(NSString *)key;
- (NSDate *)dateWithKey:(NSString *)key;
@end
