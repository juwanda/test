//
//  Reminder.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

+ (void)addReminderWhichStarts:(NSDate *)startDate andEnds:(NSDate *)endDate message:(NSString *)message {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];

    [event setTitle:message];
    [event setStartDate:startDate];
    [event setEndDate:endDate];
    [endDate release];

    [event setCalendar:eventStore.defaultCalendarForNewEvents];

    NSError *err = nil;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    [eventStore release];
}

- (void)removeReminderWhichStarts:(NSDate *)startDate andEnds:(NSDate *)endDate message:(NSString *)message {        
	EKEventStore *eventStore = [[EKEventStore alloc] init];
    NSPredicate *p = [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
	NSArray *arr = [eventStore eventsMatchingPredicate:p];
	
    for (EKEvent *event in arr) {
        if ([event.title compare:message] == NSOrderedSame) {
            NSError *err = nil;
            [eventStore removeEvent:event span:EKSpanThisEvent error:&err];   
        }
    }
	[eventStore release];
}

@end
