#import "GTSForm.h"



@implementation GTSForm {
	__strong NSMutableArray *sections;
}

- (id)init {
	self = [super init];
	if (self) {
		sections = [NSMutableArray array];
	}
	return self;
}

- (void)addSection:(GTSSection *)section {
	[sections addObject:section];
}

- (NSInteger)sectionsCount {
	return [sections count];
}
@end
