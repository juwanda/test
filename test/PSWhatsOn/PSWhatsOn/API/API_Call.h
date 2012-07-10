//
//  API_Call.h
//  Copyright 2011 alva@metric-design.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@class API_Call;

typedef enum {
	API_CALL_STRING,
	API_CALL_BINARY
} API_CallType;

typedef enum {
	API_RESULT_OK,
	API_RESULT_INTERNET_ERROR,
	API_RESULT_CONNECTION_ERROR,
	API_RESULT_CANCELED
} API_CallResult;

@protocol API_Delegate<NSObject>
-(void)onAPICallFinishedUpdate:(API_Call *)call;
@end

@interface API_Call : NSObject {
@protected
	API_CallType callType;
	NSURLConnection *curConnection;
	NSMutableData *receivedData;
    NSURLRequestCachePolicy policy;
}

@property (nonatomic, retain) id<API_Delegate> delegate;
@property (nonatomic, readonly) API_CallResult result;
@property (nonatomic, readonly) BOOL parseResult;
@property (nonatomic, readonly) NSString *errResult;
@property (nonatomic, assign) int tag;
@property (nonatomic, assign) int timeStamp;

-(id)initWithType:(API_CallType)type;
-(NSDictionary *)props;
-(NSDictionary *)propsType; //content type for specified props
-(void)update;
-(void)post:(NSString *)content;
-(void)postMultiPart;
-(void)cancel;
-(void)setErrString:(NSString *)str;

@end
