#import "GTSLabelElement.h"
#import "GTSLabelCell.h"

@implementation GTSLabelElement

@synthesize label;

- (NSString *)cellReusableIdentifier {
    return @"GTSLabelCellIdentifier";
}

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
    GTSLabelCell *cell = (GTSLabelCell*)[super getCellForTableView:tableView];
    
    cell.label.text = self.label;
    
    return cell;
}

@end
