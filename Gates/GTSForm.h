#import <Foundation/Foundation.h>

@class GTSSection;

@interface GTSForm : NSObject

- (void)addSection:(GTSSection *)section;
- (NSInteger)sectionsCount;
@end
