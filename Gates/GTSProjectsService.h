#import <Foundation/Foundation.h>

@class GTSProject;

@interface GTSProjectsService : NSObject

+ (GTSProjectsService *)sharedInstance;

- (NSMutableArray *)projects;
- (BOOL)saveProject:(GTSProject*)project;
- (BOOL)removeProject:(GTSProject*)project;
- (GTSProject *)loadProjectWithTitle:(NSString *)title;
@end
