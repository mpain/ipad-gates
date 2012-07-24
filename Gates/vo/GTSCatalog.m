#import "GTSCatalog.h"
#import "GTSCatalogOption.h"
#import "NSDictionary+LoadValues.h"

@implementation GTSCatalog

@synthesize options = _options;
@synthesize priceTable = _priceTable;
@synthesize date = _date;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSArray *options = [dictionary objectForKey:@"options"];
        if (options) {
            _options = [NSMutableArray array];
            [options enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *finish) {
                GTSCatalogOption *option = [[GTSCatalogOption alloc] initWithDictionary:obj];
                [_options addObject:option];
            }];

            _priceTable = [GTSPriceTable priceTableFromDictionary:dictionary forKey:@"table"];
            _date = [dictionary dateWithKey:@"date"];
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\n[date: %@,\npriceTable: %@,\noptions: %@]",
                    [self class],
                    self.date,
                    self.priceTable,
                    self.options];
}
@end
