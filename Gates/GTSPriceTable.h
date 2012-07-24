#import <Foundation/Foundation.h>
#import "GTSDimention.h"
#import "GTSJSONProtocol.h"

@interface GTSPriceTable : NSObject<GTSJsonProtocol>

@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) GTSDimention *width;
@property (nonatomic, strong) GTSDimention *height;

+ (GTSPriceTable *)priceTableFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
@end