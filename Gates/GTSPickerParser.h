
@protocol GTSPickerParser<NSObject>

@required
- (NSString *)objectFromComponentsValues:(NSArray *)componentsValues;
- (NSArray *)componentsValuesFromObject:(NSString*)object;

@optional
- (NSString *)presentationOfObject:(id)object;

@end
