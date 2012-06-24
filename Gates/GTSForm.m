#import "GTSForm.h"
#import "GTSSection.h"


@implementation GTSForm {
	
}

@synthesize sections;

- (id)init {
	self = [super init];
	if (self) {
		self.sections = [NSMutableArray array];
	}
	return self;
}

- (void)addSection:(GTSSection *)section {
    section.form = self;
	[self.sections addObject:section];
}

- (NSInteger)sectionsCount {
	return [self.sections count];
}

- (void)fetchValueIntoObject:(id)object {
    for (GTSSection *section in sections) {
        [section fetchValueIntoObject:object];
    }
}
@end
