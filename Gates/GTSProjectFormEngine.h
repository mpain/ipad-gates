#import "GTSElementDelegate.h"

@class GTSForm;

@protocol GTSFormEngineDelegate <NSObject>
- (void)reloadAnElement:(GTSRowElement *)element;
- (void)showElements:(NSArray *)elementsToShow hideElements:(NSArray *)elementsToHide;
@end


@interface GTSProjectFormEngine : NSObject<GTSElementDelegate>

@property (nonatomic, strong) GTSForm *form;
@property (nonatomic, weak) id<GTSFormEngineDelegate> delegate;

+ (GTSProjectFormEngine *)sharedInstance;
- (void)build;

@end
