#import <UIKit/UIKit.h>

@class GTSRowElement;
@class GTSForm;

@interface GTSFormTableView : UITableView

- (NSIndexPath *)indexForElement:(GTSRowElement *)element;
- (UITableViewCell *)cellForElement:(GTSRowElement *)element;

- (GTSForm *)form;

@end
