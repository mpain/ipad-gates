#import <Foundation/Foundation.h>

@class GTSRowElement;

@protocol GTSElementDelegate <NSObject>

- (void)valueChangedForElement:(GTSRowElement *)element;

@end
