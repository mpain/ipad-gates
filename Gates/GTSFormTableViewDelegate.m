#import "GTSFormTableViewDelegate.h"
#import "GTSFormTableView.h"
#import "GTSForm.h"
#import "GTSSection.h"

#define kHeaderHeight 36.0f

@implementation GTSFormTableViewDelegate {
	__weak GTSFormTableView *_owner;
}


- (id)initWithTableView:(GTSFormTableView *)tableView {
    self = [super init];
    if (self) {
		_owner = tableView;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return kHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	GTSFormHeaderView *header = [[GTSFormHeaderView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kHeaderHeight) andSection:section];
	header.textLabel.text = ((GTSSection *)[[self convertToTableView:tableView].form.sections objectAtIndex:section]).title;
	header.delegate = self;
	return header;
}


- (void)formHeaderView:(GTSFormHeaderView *)headerView sectionClosed:(NSInteger)section {
	[self formHeaderView:headerView section:section open:NO];
}

- (void)formHeaderView:(GTSFormHeaderView *)headerView sectionOpened:(NSInteger)section {
	[self formHeaderView:headerView section:section open:YES];
}

- (void)formHeaderView:(GTSFormHeaderView *)headerView section:(NSInteger)section open:(BOOL)open {
	GTSSection *formSection = [_owner.form.sections objectAtIndex:section];
	
	NSMutableArray *pathsToAction = [NSMutableArray arrayWithCapacity:formSection.visibleElementsCount];
	for (NSInteger i = 0; i < formSection.visibleElementsCount; i++) {
		[pathsToAction addObject:[NSIndexPath indexPathForRow:i inSection:section]];
	}
	
	formSection.hidden = !open;
	
	[_owner beginUpdates];
	if (open) {
		[_owner insertRowsAtIndexPaths:pathsToAction withRowAnimation:UITableViewRowAnimationBottom];
	} else {
		[_owner deleteRowsAtIndexPaths:pathsToAction withRowAnimation:UITableViewRowAnimationTop];
	}
	[_owner endUpdates];

}
@end
