#import "GTSPageScrollView.h"
#import <QuartzCore/QuartzCore.h>

#define kDefaultCapacity 3
#define kPageControlOffset -2
#define kPageIndicatorDiameter 10
#define kPageINdicatorSpacing 4

@implementation GTSPageScrollView {
@private
	__strong NSMutableArray *_visiblePages;
	__strong UIView *_selectedPage;
	
	NSRange _visibleIndices;
}

@synthesize scrollView = _scrollView;
@synthesize dataSource = _dataSource;
@synthesize numberOfPages = _numberOfPages;



#pragma mark - Properties -

- (void)setNumberOfPages:(NSInteger)numberOfPages {
	_numberOfPages = numberOfPages;
	
	CGSize size = _scrollView.bounds.size;
	_scrollView.contentSize = CGSizeMake(_numberOfPages * size.width, size.height);
}

#pragma mark - Setup -
- (void)awakeFromNib {
	[super awakeFromNib];
	
	_visiblePages = [NSMutableArray arrayWithCapacity:kDefaultCapacity];
	
	[self setupScrollView];
	
	_numberOfPages = 1;
	_visibleIndices.location = 0;
	_visibleIndices.length = 1;
    
	[self reloadData];
}



- (void)setupScrollView {
	UIGestureRecognizer *recognizer = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureFrom:)];
	recognizer.delegate = self;
	[_scrollView addGestureRecognizer:recognizer];
	_scrollView.decelerationRate = 1.0f;
	_scrollView.delaysContentTouches = NO;
	_scrollView.clipsToBounds = NO;
	_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (NSInteger)determineNumberOfPages {
	NSInteger pagesNumber = 0;
	if ([self.dataSource respondsToSelector:@selector(numberOfPagesInScrollView:)]) {
		pagesNumber = [self.dataSource numberOfPagesInScrollView:self];
	}
	
	return pagesNumber;
}

- (void)reload {
	_selectedPage = nil;
	[self reloadData];
}

- (void)reloadData {
	self.numberOfPages = [self determineNumberOfPages];
	
	NSInteger selectedIndex = _selectedPage ? [_visiblePages indexOfObject:_selectedPage] : 0;
	if (selectedIndex == NSNotFound) {
		selectedIndex = 0;
	}
	
	[_visiblePages removeAllObjects];
	
	[[_scrollView subviews] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		[object removeFromSuperview];
	}];
	
	if (!self.numberOfPages) {
		return;
	}
	
	for (int index = 0; index < _visibleIndices.length; index++) {
		UIView *page = [self loadPageAtIndex:_visibleIndices.location + index andInsertItIntoVisibleIndex:index];
		[self addPageToScrollView:page atIndex:_visibleIndices.location + index];
	}
	
	[self updateVisiblePages];
	
	
	_selectedPage = [_visiblePages objectAtIndex:selectedIndex];
}

- (UIView*)loadPageAtIndex:(NSInteger)index andInsertItIntoVisibleIndex:(NSInteger)visibleIndex {
	UIView *visiblePage = [self.dataSource pageScrollView:self viewForPageAtIndex:index];
	
	[_visiblePages insertObject:visiblePage atIndex:visibleIndex];
	return visiblePage;
}

- (void)addPageToScrollView:(UIView*)page atIndex:(NSInteger)index {
    [self setFrameForPage:page atIndex:index];
    [_scrollView insertSubview:page atIndex:0];
}

- (void)setFrameForPage:(UIView*)page atIndex:(NSInteger)index {
	CGRect frame = page.frame;
	frame.origin.x = index * _scrollView.frame.size.width;
	frame.origin.y = 0.0;
	page.frame = frame;
}

- (void)updateScrolledPage:(UIView*)page index:(NSInteger)index {
    _selectedPage = page;
}

- (void)updateVisiblePages {
	CGFloat pageWidth = _scrollView.frame.size.width;
	
	CGFloat leftViewOriginX = _scrollView.frame.origin.x - _scrollView.contentOffset.x + (_visibleIndices.location * pageWidth);
	CGFloat rightViewOriginX = _scrollView.frame.origin.x - _scrollView.contentOffset.x + (_visibleIndices.location + _visibleIndices.length - 1) * pageWidth;
	
	if (leftViewOriginX > 0) {
		if (_visibleIndices.location > 0) {
			_visibleIndices.length += 1;
			_visibleIndices.location -= 1;
			UIView *page = [self loadPageAtIndex:_visibleIndices.location andInsertItIntoVisibleIndex:0];
            [self addPageToScrollView:page atIndex:_visibleIndices.location ];
		}
	} else if (leftViewOriginX < -pageWidth) {
		UIView *page = [_visiblePages objectAtIndex:0];
        [_visiblePages removeObject:page];
        [page removeFromSuperview];
		_visibleIndices.location += 1;
		_visibleIndices.length -= 1;
	}
	
	if (rightViewOriginX > self.frame.size.width) {
		UIView *page = [_visiblePages lastObject];
        [_visiblePages removeObject:page];
        [page removeFromSuperview];
		_visibleIndices.length -= 1;
	} else if (rightViewOriginX + pageWidth < self.frame.size.width) {
		if (_visibleIndices.location + _visibleIndices.length < _numberOfPages) {
			_visibleIndices.length += 1;
            NSInteger index = _visibleIndices.location + _visibleIndices.length - 1;
			UIView *page = [self loadPageAtIndex:index andInsertItIntoVisibleIndex:_visibleIndices.length - 1];
            [self addPageToScrollView:page atIndex:index];
		}
	}
}

- (NSInteger)indexForSelectedPage {
    return [self indexForVisiblePage:_selectedPage];
}

- (NSInteger)indexForVisiblePage:(UIView*)page {
	NSInteger index = [_visiblePages indexOfObject:page];
    return (index != NSNotFound) ? _visibleIndices.location + index : NSNotFound;
}

#pragma mark -
#pragma mark Handling Touches


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return !_scrollView.decelerating && !_scrollView.dragging;
}

- (void)handleTapGestureFrom:(UITapGestureRecognizer *)recognizer {
    if (!_selectedPage) {
        return;
	}
    
	NSInteger selectedIndex = [self indexForSelectedPage];
	[self selectPageAtIndex:selectedIndex animated:YES];
}

- (void)selectPageAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index == NSNotFound || _numberOfPages == 0) {
        return;
    }
    
	if (index != [self indexForSelectedPage]) {
        BOOL isLastPage = (index == _numberOfPages - 1);
        BOOL isFirstPage = (index == 0); 
        NSInteger selectedVisibleIndex; 
        if (_numberOfPages == 1) {
            _visibleIndices.location = index;
            _visibleIndices.length = 1;
            selectedVisibleIndex = 0;
        } else if (isLastPage) {
            _visibleIndices.location = index - 1;
            _visibleIndices.length = 2;
            selectedVisibleIndex = 1;
        } else if (isFirstPage) {
            _visibleIndices.location = index;
            _visibleIndices.length = 2;                
            selectedVisibleIndex = 0;
        } else {
            _visibleIndices.location = index - 1;
            _visibleIndices.length = 3;           
            selectedVisibleIndex = 1;
        }
		
        _scrollView.contentOffset = CGPointMake(index * _scrollView.frame.size.width, 0);
		[self reloadData];
        
        _selectedPage = [_visiblePages objectAtIndex:selectedVisibleIndex];		
	}
    
	// TODO: action
}

- (void)layoutSubviews {
	[super layoutSubviews];
//	[self reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self updateVisiblePages];
	
	CGFloat delta = scrollView.contentOffset.x - _selectedPage.frame.origin.x;
	BOOL toggleNextItem = (fabs(delta) > scrollView.frame.size.width / 2);
	if (toggleNextItem && [_visiblePages count] > 1) {
		NSInteger selectedIndex = [_visiblePages indexOfObject:_selectedPage];
		BOOL isNeighbourExist = (delta < 0 && selectedIndex > 0) || (delta > 0 && selectedIndex < _visiblePages.count - 1);
		
		if (isNeighbourExist) {
			NSInteger neighborPageVisibleIndex = [_visiblePages indexOfObject:_selectedPage] + (delta > 0 ? 1 : -1);
			UIView *neighbourPage = [_visiblePages objectAtIndex:neighborPageVisibleIndex];
			NSInteger neighbourIndex = _visibleIndices.location + neighborPageVisibleIndex;
			
			[self updateScrolledPage:neighbourPage index:neighbourIndex];
			
		}
		
	}
	
}

@end
