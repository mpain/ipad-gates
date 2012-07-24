#import <Foundation/Foundation.h>
#import "GTSDebugDataLoader.h"
#import "GTSFormatters.h"

@interface GTSServiceLocator : NSObject

@property (nonatomic, strong, readonly) GTSFormatters *formatters;
@property (nonatomic, strong, readonly) GTSDebugDataLoader *debugDataLoader;

@end
