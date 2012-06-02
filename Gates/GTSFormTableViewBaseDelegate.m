#import "GTSFormTableViewBaseDelegate.h"
#import "GTSFormTableView.h"

@implementation GTSFormTableViewBaseDelegate

- (GTSFormTableView *)convertToTableView:(UITableView *)aTableView {
	assert([aTableView isKindOfClass:[GTSFormTableView class]]);
	return (GTSFormTableView *)aTableView;
}

@end
