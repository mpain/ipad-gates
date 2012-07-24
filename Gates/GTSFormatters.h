#import <Foundation/Foundation.h>

@interface GTSFormatters : NSObject

@property (nonatomic, readonly, strong) NSNumberFormatter *floatNumberFormatter;
@property (nonatomic, readonly, strong) NSDateFormatter *dateFormatter;

@end
