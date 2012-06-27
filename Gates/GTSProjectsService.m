#import "GTSProjectsService.h"
#import "GTSProject.h"

@implementation GTSProjectsService {
	__strong NSString *_documentsDirectory;
}

+ (GTSProjectsService *)sharedInstance {
    static dispatch_once_t once;
    __strong static id _sharedInstance = nil;
    dispatch_once(&once, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (NSString *)documentsDirectory {
	if (!_documentsDirectory) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		_documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"projects"];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		if (![fileManager fileExistsAtPath:_documentsDirectory]) {
			[fileManager createDirectoryAtPath:_documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
		}
			
	}
    return _documentsDirectory;
}

- (NSString *)projectFileNameForTitle:(NSString *)title {
	return [self.documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", title]];
}

- (NSMutableArray *)projects {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *documents = [fileManager contentsOfDirectoryAtPath:[self documentsDirectory] error:nil];

	NSMutableArray *results = [NSMutableArray array];
	for (NSString *document in documents) {
		NSData *documentData = [fileManager contentsAtPath:[[self documentsDirectory] stringByAppendingPathComponent:document]];
		
		NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:documentData options:(NSJSONReadingAllowFragments | NSJSONReadingMutableContainers) error:nil];
		[results addObject:[[GTSProject alloc] initWithDictionary:dictionary]];
	}
	
	return results;
}

- (BOOL)saveProject:(GTSProject*)project {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [self projectFileNameForTitle:project.title];
	
	__autoreleasing NSError *error = nil;
	
	if ([fileManager fileExistsAtPath:path]) {
		[fileManager removeItemAtPath:path error:&error];
	}
	
	if (!error) {
		NSLog(@"Project : %@", [project description]);
		
		NSData *data = [NSJSONSerialization dataWithJSONObject:[project serializeToDictionary] options:NSJSONWritingPrettyPrinted error:&error];
		if (!error) {
			NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			NSLog(@"Saved file content is: %@", content);
			
			[fileManager createFileAtPath:path contents:data attributes:nil];
		}
	}
	
	return (error == nil);
}

- (BOOL)removeProject:(GTSProject*)project {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [self projectFileNameForTitle:project.title];
	
	__autoreleasing NSError *error = nil;
	
	if ([fileManager fileExistsAtPath:path]) {
		[fileManager removeItemAtPath:path error:&error];
	}
	
	return (error == nil);
}


- (GTSProject *)loadProjectWithTitle:(NSString *)title {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [self projectFileNameForTitle:title];
	
	if (![fileManager fileExistsAtPath:path]) {
		return nil;
	}
	
	NSData *documentData = [fileManager contentsAtPath:path];
	
	__autoreleasing NSError *error = nil;
	NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:documentData options:(NSJSONReadingAllowFragments | NSJSONReadingMutableContainers) error:nil];	
	return (!error) ? [[GTSProject alloc] initWithDictionary:dictionary] : nil;
}

- (void)shit {
	NSString *bundleDirectory = [[NSBundle mainBundle] resourcePath];
}
@end
