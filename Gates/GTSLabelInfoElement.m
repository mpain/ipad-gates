#import "GTSLabelInfoElement.h"
#import "GTSLabelInfoCell.h"

@implementation GTSLabelInfoElement

@synthesize info;

- (NSString *)cellReusableIdentifier {
    return @"GTSLabelInfoCellIdentifier";
}

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
    GTSLabelInfoCell *cell = (GTSLabelInfoCell *)[super getCellForTableView:tableView];
    [cell updateInfoFromElement];
    return cell;
}
@end
