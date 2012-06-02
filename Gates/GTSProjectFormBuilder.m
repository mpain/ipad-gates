#import "GTSProjectFormBuilder.h"
#import "GTSForm.h"
#import "GTSSection.h"

@implementation GTSProjectFormBuilder
+ (GTSSection*)buildFurnishingSection {
	GTSSection *section = [GTSSection new];
	
	return section;
}

+ (GTSForm *)build {
	GTSForm *form = [GTSForm new];
	[form addSection:[self buildFurnishingSection]];
	return form;
}

@end
