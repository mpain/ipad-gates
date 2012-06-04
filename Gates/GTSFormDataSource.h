#import <Foundation/Foundation.h>
#import "GTSFormTableViewBaseDelegate.h"
#import "GTSProjectFormEngine.h"

@class GTSForm;

@interface GTSFormDataSource : GTSFormTableViewBaseDelegate<UITableViewDataSource, GTSFormEngineDelegate>

@property (nonatomic, readonly, strong) GTSForm *form;

- (id)initWithTableView:(GTSFormTableView *)aTableView;

@end
