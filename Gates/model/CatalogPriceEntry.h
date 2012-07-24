#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Catalog;

@interface CatalogPriceEntry : NSManagedObject

@property (nonatomic, strong) NSNumber * width;
@property (nonatomic, strong) NSNumber * height;
@property (nonatomic, strong) NSDecimalNumber * amount;
@property (nonatomic, strong) Catalog *catalog;

@end
