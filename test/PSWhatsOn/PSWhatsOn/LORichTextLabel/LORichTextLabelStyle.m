//
//  LORichTextLabelStyle.m
//  RichTextLabel
//
//  Created by Locassa on 19/06/2011.
//  Copyright 2011 Locassa Ltd. All rights reserved.
//

#import "LORichTextLabelStyle.h"


@implementation LORichTextLabelStyle


@synthesize font;
@synthesize color;
@synthesize target;
@synthesize action;
@synthesize removePrefix;

+ (LORichTextLabelStyle *)styleWithFont:(UIFont *)aFont color:(UIColor *)aColor {
	LORichTextLabelStyle *style = [[LORichTextLabelStyle alloc] init];
	[style setFont:aFont];
	[style setColor:aColor];
	
	return [style autorelease];
}

- (void)dealloc {
	[font release];
	[color release];
	[super dealloc];
}

- (void)addTarget:(id)aTarget action:(SEL)anAction {
	target = aTarget;
	action = anAction;
}

@end
