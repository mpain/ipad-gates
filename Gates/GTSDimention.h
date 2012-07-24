#import <Foundation/Foundation.h>
#import "GTSJsonProtocol.h"

@interface GTSDimention : NSObject<GTSJsonProtocol>

@property (nonatomic, assign) NSInteger startValue;
@property (nonatomic, assign) NSInteger step;

+ (GTSDimention *)dimentionFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
@end