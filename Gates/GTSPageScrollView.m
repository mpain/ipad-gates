#import "GTSPageScrollView.h"
#import <QuartzCore/QuartzCore.h>

#define kDefaultCapacity 3
#define kPageControlOffset -2
#define kPageIndicatorDiameter 10
#define kPageINdicatorSpacing 4

@implementation GTSPageScrollView {
@private
	__strong NSMutableArray *_visiblePages;
	NSInteger _currentIndex;
}

@synthesize scrollView = _scrollView;
@synthesize dataSource = _dataSource;
@synthesize numberOfPages = _numberOfPages;



#pragma mark - Properties -

- (void)setNumberOfPages:(NSInteger)numberOfPages {
	_numberOfPages = numberOfPages;
	[self updateContentSize];
}

#pragma mark - Setup -
- (void)awakeFromNib {
	[super awakeFromNib];
	
	_visiblePages = [NSMutableArray arrayWithCapacity:kDefaultCapacity];
	_numberOfPages = 0;
	
    [self setupScrollView];
	[self reloadData];
}

- (void)updateContentSize {
	CGSize size = _scrollView.bounds.size;
	_scrollView.contentSize = CGSizeMake(_numberOfPages * size.width, size.height);
}

- (void)setupScrollView {
	_scrollView.decelerationRate = 1.0f;
	_scrollView.delaysContentTouches = NO;
	_scrollView.clipsToBounds = NO;
	_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (NSInteger)obtainNumberOfPages {
	NSInteger pagesNumber = 0;
	if ([self.dataSource respondsToSelector:@selector(numberOfPagesInScrollView:)]) {
		pagesNumber = [self.dataSource numberOfPagesInScrollView:self];
	}
	
	return pagesNumber;
}

- (void)reload {
	_currentIndex = 0;
	[self reloadData];
}

- (void)reloadData {
	self.numberOfPages = [self obtainNumberOfPages];
	[_visiblePages removeAllObjects];
	
	[[_scrollView subviews] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		[object removeFromSuperview];
	}];
	
	if (!self.numberOfPages) {
		return;
	}
	
	for (NSInteger index = 0; index < kDefaultCapacity; index++) {
		NSInteger pageNumber = (_currentIndex - 1 + index);
		[self loadPage:pageNumber toCacheAtPosition:index];
	}
}

- (void)loadPage:(NSInteger)pageNumber toCacheAtPosition:(NSInteger)position {
	BOOL isPageExisted = (pageNumber >= 0 && pageNumber < self.numberOfPages);
	
	id page = isPageExisted ? [self.dataSource pageScrollView:self viewForPageAtIndex:pageNumber] : nil;
	if (!page) {
		page = [NSNull null];
	}
	
	[_visiblePages insertObject:page atIndex:position];
	if ([page isKindOfClass:[UIView class]]) {
		[self addPageToScrollView:page pageIndex:pageNumber];
	}
}

- (void)addPageToScrollView:(UIView*)page pageIndex:(NSInteger)index {
    [self setFrameForPage:page atIndex:index];
    [_scrollView addSubview:page];
}

- (void)setFrameForPage:(UIView*)page atIndex:(NSInteger)index {
	page.frame = CGRectMake(index * _scrollView.frame.size.width, 0.0, _scrollView.frame.size.width, _scrollView.frame.size.height);
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self fixFrames];
	
	[_scrollView layoutSubviews];
	[self fixContentOffset];
	
	[[_scrollView subviews] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		[[object subviews] enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
			[target layoutSubviews];
		}];
	}];	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (!scrollView.dragging && !scrollView.decelerating) {
		return;
	}
	
	CGFloat delta = _scrollView.contentOffset.x - _currentIndex * _scrollView.bounds.size.width;
	if (abs(delta) < _scrollView.bounds.size.width) {
		return;
	}
	
	NSInteger currentIndex = (_scrollView.contentOffset.x /*+ (_scrollView.bounds.size.width / 2)*/) / _scrollView.bounds.size.width;
	NSInteger step = (currentIndex - _currentIndex);
	if (!step) {
		return;
	}
	
	if (abs(step) != 1) {
		_currentIndex = currentIndex;
		[self reloadData];
		return;
	}
	
	NSInteger indexToRemove = (step > 0) ? 0 : _visiblePages.count - 1;
	
	id targetToRemove = [_visiblePages objectAtIndex:indexToRemove];
	if ([targetToRemove isKindOfClass:[UIView class]]) {
		[targetToRemove removeFromSuperview];
	}
	
	[_visiblePages removeObjectAtIndex:indexToRemove];
	
	NSInteger indexToAdd = (step > 0) ?  _visiblePages.count : 0;
	[self loadPage:currentIndex + step toCacheAtPosition:indexToAdd];
	
	NSLog(@"The current page is: %d", currentIndex);
	_currentIndex = currentIndex;
}

- (void)fixFrames {
	[self updateContentSize];
	for (NSInteger index = 0; index < kDefaultCapacity; index++) {
		id page = [_visiblePages objectAtIndex:index];
		if ([page isKindOfClass:[UIView class]]) {
			[self setFrameForPage:page atIndex:(_currentIndex - 1 + index)];
		}
	}
}

- (void)fixContentOffset {
	_scrollView.contentOffset = CGPointMake(_currentIndex * _scrollView.bounds.size.width, 0.0f);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView.dragging || scrollView.decelerating) {
		return;
	}

	[self fixFrames];
	[self fixContentOffset];
}
@end
