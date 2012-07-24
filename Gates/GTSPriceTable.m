#import "GTSPriceTable.h"


@implementation GTSPriceTable

@synthesize prices = _prices;
@synthesize width = _width;
@synthesize height = _height;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _width = [GTSDimention dimentionFromDictionary:dictionary forKey:@"width"];
        _height = [GTSDimention dimentionFromDictionary:dictionary forKey:@"height"];
        _prices = [dictionary objectForKey:@"entries"];
    }
    return self;
}

+ (GTSPriceTable *)priceTableFromDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSDictionary *data = [dictionary objectForKey:key];
    if (!data) {
        return nil;
    }

    return [[GTSPriceTable alloc] initWithDictionary:data];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ [width: %@, height: %@, prices: %@]",
                    [self class],
                    self.width,
                    self.height,
                    self.prices];
}
@end