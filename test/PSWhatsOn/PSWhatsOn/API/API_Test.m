//
//  API_Test.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "API_Test.h"

@implementation API_TestItem
@synthesize name, imagePath;

- (void)dealloc {
    [name release];
    [imagePath release];
    [super dealloc];
}

@end

@implementation API_Test
@synthesize outItems;

- (void)dealloc {
    [outItems release];
    [super dealloc];
}

- (NSString *)param {
	return @"/collections/4fcfc4f5b9935e26d8000005/entries.json?auth_token=yTZDticcTeFDMQwpB5Q1";
}

- (BOOL)parseString:(NSString *)str {
    //NSLog(@"API_Test: %@", str);
    NSDictionary *rootDict = [str JSONValue];
    if (rootDict && [rootDict isKindOfClass:[NSDictionary class]]) {
        NSDictionary *arrDict = [rootDict objectForKey:@"array"];
        if (arrDict && [arrDict isKindOfClass:[NSDictionary class]]) {
            NSArray *resArr = [arrDict objectForKey:@"resources"];
            if (resArr && [resArr isKindOfClass:[NSArray class]]) {
                if (outItems == nil) {
                    outItems = [[NSMutableArray alloc] init];
                } else {
                    [outItems removeAllObjects];
                }
                
                for (NSDictionary *resDict in resArr) {
                    API_TestItem *item = [[API_TestItem alloc] init];
                    item.name = [resDict objectForKey:@"name"];
                    item.imagePath = [resDict objectForKey:@"image_path"];
                    [outItems addObject:item];
                    [item release];
                }
            }
        }
        return TRUE;
    }
	return FALSE;
}

@end
