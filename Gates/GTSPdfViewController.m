#import "GTSPdfViewController.h"
#import "GTSPdfViewContainer.h"

@implementation GTSPdfViewController {
	CGPDFDocumentRef _document;
	NSUInteger _numberOfPages;
}

@synthesize documentName = _documentName;

- (void)dealloc {
	[self releaseDocument];
}

- (void)releaseDocument {
	if (_document) {
		CGPDFDocumentRelease(_document);
		_document = nil;
		_numberOfPages = 0;
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self loadDocumentWithName:@"booklet.pdf"];
}

- (void)viewDidUnload {
	[self releaseDocument];
}

- (void)loadDocumentWithName:(NSString *)name {
	NSRange range = [name rangeOfString:@".pdf"];
	
	_documentName = [name copy];
	if (range.location != NSNotFound && range.location == (name.length - 4)) {
		_documentName = [_documentName substringToIndex:range.location];
	}
	
	[self reloadDocument];
}

- (void)reloadDocument {
	[self releaseDocument];
	if (_documentName) {
		NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:_documentName withExtension:@"pdf"];
		
		_document = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfURL);
		_numberOfPages = CGPDFDocumentGetNumberOfPages(_document);
		NSLog(@"Pages: %d", _numberOfPages);
	}
    [(GTSPageScrollView *)self.view reload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIView*) pageScrollView:(GTSPageScrollView *)pageScrollView viewForPageAtIndex:(NSInteger)index {
	GTSPdfViewContainer *view = [[GTSPdfViewContainer alloc] initWithFrame:pageScrollView.bounds];
	[view pdfDocument:_document loadPageWithNumber:index + 1];
	return view;
}

- (NSInteger)numberOfPagesInScrollView:(GTSPageScrollView *)pageScrollView {
	return _numberOfPages;
}
@end
