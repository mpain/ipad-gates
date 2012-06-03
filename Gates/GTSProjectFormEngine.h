#import "GTSElementDelegate.h"

@class GTSForm;

@protocol GTSFormEngineDelegate <NSObject>
- (void)reload;
@end


@interface GTSProjectFormEngine : NSObject<GTSElementDelegate>

@property (nonatomic, strong) GTSForm *form;

+ (GTSProjectFormEngine *)sharedInstance;

@end
