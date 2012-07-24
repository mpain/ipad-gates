#import <Foundation/Foundation.h>
#import "GTSJsonProtocol.h"
#import "GTSPriceTable.h"

@interface GTSCatalog : NSObject<GTSJsonProtocol>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) GTSPriceTable *priceTable;
@property (nonatomic, strong) NSMutableArray *options;

@end
