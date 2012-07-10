//
//  LORichTextLabelStyle.m
//  RichTextLabel
//
//  Created by Locassa on 19/06/2011.
//  Copyright 2011 Locassa Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LORichTextLabelStyle : NSObject {
	UIFont *font;
	UIColor *color;	
	id target;
	SEL action;
}

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, readonly) id target;
@property (nonatomic, readonly) SEL action;
@property (nonatomic, assign) BOOL removePrefix;

+ (LORichTextLabelStyle *)styleWithFont:(UIFont *)aFont color:(UIColor *)aColor;
- (void)addTarget:(id)target action:(SEL)action;

@end
