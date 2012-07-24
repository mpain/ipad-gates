#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Catalog;

@interface CatalogAccessoryEntry : NSManagedObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSDecimalNumber * value;
@property (nonatomic, strong) NSDecimalNumber * area;
@property (nonatomic, strong) Catalog *catalog;

@end
