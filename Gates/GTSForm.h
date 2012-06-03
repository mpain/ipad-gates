#import <Foundation/Foundation.h>
#import "GTSElementDelegate.h"

@class GTSSection;

@interface GTSForm : NSObject

@property (nonatomic, strong) NSMutableArray *sections;

- (void)addSection:(GTSSection *)section;
- (NSInteger)sectionsCount;

@end
