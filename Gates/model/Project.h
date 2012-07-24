#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectPicture, ProjectType;

@interface Project : NSManagedObject

@property (nonatomic, strong) NSData * json;
@property (nonatomic, strong) ProjectType *type;
@property (nonatomic, strong) NSSet *pictures;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(ProjectPicture *)value;
- (void)removePicturesObject:(ProjectPicture *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

@end
