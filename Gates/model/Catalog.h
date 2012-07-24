#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CatalogAccessoryEntry;

@interface Catalog : NSManagedObject

@property (nonatomic, strong) NSDate * date;
@property (nonatomic, strong) NSData * price;
@property (nonatomic, strong) NSSet *accessoryEntries;
@end

@interface Catalog (CoreDataGeneratedAccessors)

- (void)addAccessoryEntriesObject:(CatalogAccessoryEntry *)value;
- (void)removeAccessoryEntriesObject:(CatalogAccessoryEntry *)value;
- (void)addAccessoryEntries:(NSSet *)values;
- (void)removeAccessoryEntries:(NSSet *)values;

@end
