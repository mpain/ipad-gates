#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface ProjectPicture : NSManagedObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSData * image;
@property (nonatomic, strong) Project *project;

@end
