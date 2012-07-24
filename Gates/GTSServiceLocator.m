#import "GTSServiceLocator.h"

@implementation GTSServiceLocator

@synthesize formatters = _formatters;
@synthesize debugDataLoader = _debugDataLoader;

- (id)init {
	self = [super init];
	if (self) {
		_formatters = [[GTSFormatters alloc] init];
		_debugDataLoader = [[GTSDebugDataLoader alloc] init];
	}
	return self;
}

@end
