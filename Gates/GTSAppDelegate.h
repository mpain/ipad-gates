#import <UIKit/UIKit.h>
#import "GTSServiceLocator.h"

#define ApplicationDelegate ((GTSAppDelegate *)[[UIApplication sharedApplication] delegate])
#define ServiceLocator [ApplicationDelegate serviceLocator]

@interface GTSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) UIStoryboard *storyboard;

@property (readonly, strong, nonatomic) GTSServiceLocator *serviceLocator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
