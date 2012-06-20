#import "GTSFormDataSource.h"
#import "GTSForm.h"
#import "GTSFormTableView.h"
#import "GTSFormTextFieldCell.h"
#import "GTSRowElement.h"
#import "GTSSection.h"

@implementation GTSFormDataSource {
	__weak GTSFormTableView *owner;
}

@synthesize form;

- (id)initWithTableView:(GTSFormTableView *)aTableView {
    self = [super init];
    if (self) {
		owner = aTableView;
		
		GTSProjectFormEngine *engine = [GTSProjectFormEngine sharedInstance];
        form = engine.form;
		engine.delegate = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [form sectionsCount];	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[form.sections objectAtIndex:section] title];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	GTSSection *formSection = [form.sections objectAtIndex:section];
	return formSection.hidden? 0 : formSection.visibleElementsCount;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	GTSFormTableView *table = [self convertToTableView:aTableView];
    
    GTSSection *section = [form.sections objectAtIndex:indexPath.section];
    GTSRowElement *element = [section elementAtIndex:indexPath.row];
    
    return [element getCellForTableView:table];
}

- (void)reloadAnElement:(GTSRowElement *)element {
	GTSFormCell *cell = (GTSFormCell *)[owner cellForElement:element];
	[cell updateCellFromElement];
	[cell setNeedsDisplay];
}

@end
