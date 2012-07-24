#import "GTSDebugDataLoader.h"
#import "GTSAppDelegate.h"
#import "Catalog.h"
#import "GTSCatalog.h"

@implementation GTSDebugDataLoader

- (void)reloadCatalog {
	[self removeAll];

    NSDictionary *data = [self loadData];
    GTSCatalog *catalog = [[GTSCatalog alloc] initWithDictionary:data];
    NSLog(@"catalog: %@", catalog);

    [self populateData:catalog.date];
}

- (void)populateData:(NSDate *)date {
	NSManagedObjectContext *context = ApplicationDelegate.managedObjectContext;
	Catalog *catalog = (Catalog *)[NSEntityDescription insertNewObjectForEntityForName:@"Catalog" inManagedObjectContext:context];
	
	catalog.date = date;
	catalog.price = [self catalogFileContent];
	[self save];
}

- (NSData *)catalogFileContent {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"catalog" ofType:@"json"];
	return [[NSFileManager defaultManager] contentsAtPath:path];
}

- (NSDictionary *)loadData {
	NSData *documentData = [self catalogFileContent];
	
	__autoreleasing NSError *error = nil;
	NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:documentData options:(NSJSONReadingAllowFragments | NSJSONReadingMutableContainers) error:&error];
	if (error) {
		NSLog(@"Error was handled during loading Catalog entries: %@", error);
		return nil;
	}
	
	NSLog(@"Data: %@", dictionary);
	return dictionary;
}

- (void)removeAll {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSManagedObjectContext *context = ApplicationDelegate.managedObjectContext;
	
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Catalog" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
	
    __autoreleasing NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
	
    for (NSManagedObject *managedObject in items) {
		[context deleteObject:managedObject];
	}
	
    if (![context save:&error]) {
        NSLog(@"Error was handled during deleting Catalog entries: %@", error);
    }
}

- (void)save {
	NSManagedObjectContext *context = ApplicationDelegate.managedObjectContext;
	
	__autoreleasing NSError *error;
	if (context.hasChanges && ![context save:&error]) {
		NSLog(@"ERROR: %@", [error localizedDescription]);
	}
}
@end
