#import <Foundation/Foundation.h>

@interface GTSFormatters : NSObject

@property (nonatomic, readonly, strong) NSNumberFormatter *floatNumberFormatter;

+ (GTSFormatters *)sharedInstance;


@end
