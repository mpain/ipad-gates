#import "GTSCatalogOption.h"
#import "NSDictionary+LoadValues.h"

@implementation GTSCatalogOption

@synthesize name = _name;
@synthesize price = _price;
@synthesize factor = _factor;
@synthesize area = _area;

- (id)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		_name = [dictionary stringWithKey:@"type"];
		_price = [dictionary decimalNumberWithKey:@"price"];
		_factor = [dictionary decimalNumberWithKey:@"factor"];
		_area = [dictionary decimalNumberWithKey:@"area"];
	}
	return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ [name: %@, price: %@, factor: %@, area: %@]",
                    [self class],
                    self.name,
                    self.price,
                    self.factor,
                    self.area];
}
@end
