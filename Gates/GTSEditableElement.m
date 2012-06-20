#import "GTSEditableElement.h"
#import "GTSEditableCell.h"

@implementation GTSEditableElement

- (NSString *)cellReusableIdentifier {
    return @"GTSEditableCellIdentifier";
}

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
    GTSEditableCell *cell = (GTSEditableCell*)[super getCellForTableView:tableView];
    
	[cell updateCellForElement:self andTableView:tableView];    
    return cell;
}

@end
