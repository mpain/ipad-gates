#import <Foundation/Foundation.h>
#import "GTSJsonProtocol.h"

@interface GTSCatalogOption : NSObject<GTSJsonProtocol>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *factor;
@property (nonatomic, strong) NSDecimalNumber *area;

@end
