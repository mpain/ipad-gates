#import <Foundation/Foundation.h>
#import "GTSFormTableViewBaseDelegate.h"
#import "GTSFormHeaderView.h"

@class GTSFormTableView;

@interface GTSFormTableViewDelegate : GTSFormTableViewBaseDelegate<UITableViewDelegate, GTSFormHeaderViewDelegate>

- (id)initWithTableView:(GTSFormTableView *)aTableView;

@end
