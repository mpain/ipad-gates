#import <Foundation/Foundation.h>
#import "GTSFormTableViewBaseDelegate.h"

@class GTSForm;

@interface GTSFormDataSource : GTSFormTableViewBaseDelegate<UITableViewDataSource>

@property (nonatomic, readonly, strong) GTSForm *form;

@end
