//
//  API_Test.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "API_Call.h"

@interface API_TestItem : NSObject 
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imagePath;
@end

@interface API_Test : API_Call
@property (nonatomic, readonly) NSMutableArray *outItems;
@end
