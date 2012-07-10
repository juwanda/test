//
//  API_Call.m
//  Copyright 2011 alva@metric-design.com. All rights reserved.
//

#import "API_Call.h"

#define BASE_ADDRESS @"http://api.storageroomapp.com/accounts/4fc86231b9935e4ecc000002"
#define TIME_OUT 20.0

@implementation API_Call
@synthesize delegate, result, parseResult, errResult, tag, timeStamp;

- (id)initWithType:(API_CallType)type {
	if ((self = [super init])) {
		callType = type;
		curConnection = nil;
		receivedData = nil;
	}
	return self;
}

- (void)dealloc {
	[errResult release];
	[delegate release];
	[super dealloc];
}

- (NSDictionary *)props {
	return nil;
}

-(NSDictionary *)propsType; {
    return nil;
}

- (NSString *)address {
	return BASE_ADDRESS;
}

- (NSString *)param {
	return @"";
}

- (BOOL)parseString:(NSString *)str {
	return FALSE;
}

- (BOOL)parseBinary:(NSData *)data {
	return FALSE;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release], curConnection = nil;
	if (callType == API_CALL_STRING) {
		NSString *str = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
		parseResult = [self parseString:str];
		[str release];
	} else {
		parseResult = [self parseBinary:receivedData];
	}
	
	if (!parseResult) {
		[self setErrString:@"Invalid server response."];
	}
	
	[receivedData release], receivedData = nil;
	[delegate onAPICallFinishedUpdate:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release], curConnection = nil;
	[receivedData release], receivedData = nil;
	result = API_RESULT_CONNECTION_ERROR;
	[self setErrString:@"Can't connect to server."];
	[delegate onAPICallFinishedUpdate:self];
}

- (void)update {
	result = API_RESULT_OK;
	
    NSString *address = [NSString stringWithFormat:@"%@%@", [self address], [self param]];
    address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	NSLog(@"%@", address);
	NSURL *url = [NSURL URLWithString:address];
	NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:policy timeoutInterval:TIME_OUT];
	curConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	
	if (curConnection) {
		receivedData = [[NSMutableData alloc] init];
	} else {
		result = API_RESULT_INTERNET_ERROR;
		[self setErrString:@"Internet connection is not available."];
		[delegate onAPICallFinishedUpdate:self];
	}
}

- (void)post:(NSString *)content {
    NSLog(@"content: %@", content);
	NSData *cdata = [content dataUsingEncoding:NSASCIIStringEncoding];	
	NSString *clen = [NSString stringWithFormat:@"%d", [cdata length]];
	
	NSMutableURLRequest *req = [[[NSMutableURLRequest alloc] init] autorelease];
	NSString *address = [NSString stringWithFormat:@"%@%@", [self address], [self param]];
	address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	   
	NSLog(@"post: %@ len: %@", address, clen);
	
	[req setURL:[NSURL URLWithString:address]];
	[req setHTTPMethod:@"POST"];
	[req setValue:clen forHTTPHeaderField:@"Content-Length"];
	[req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [req setTimeoutInterval:TIME_OUT];
	[req setHTTPBody:cdata];
	
	curConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	
	if (curConnection) {
		receivedData = [[NSMutableData alloc] init];
	} else {
		result = API_RESULT_INTERNET_ERROR;
		[self setErrString:@"Internet connection is not available."];
		[delegate onAPICallFinishedUpdate:self];
	}
}

- (void)postMultiPart {
	NSString* boundary = @"----Boundary+AaB03x";
	
	NSString *address = [NSString stringWithFormat:@"%@%@", [self address], [self param]];
	NSMutableData* postBody = [[NSMutableData alloc] init];
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:address] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:TIME_OUT];
	[req setHTTPMethod:@"POST"];
	[req setValue:address forHTTPHeaderField:@"Referer"];
	[req setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
	
	NSDictionary *props = [self props];
    NSDictionary *propsType = [self propsType];
	if (props) {
		NSEnumerator* dictionaryEnumerator = [props keyEnumerator];
		NSString* currentKey = nil;
		while ((currentKey = [dictionaryEnumerator nextObject]))
		{
			id currentValue = [props objectForKey:currentKey];
            NSMutableString *dataString = [NSMutableString string];
            [dataString appendFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"", boundary, currentKey];
            
            NSString *type = [propsType objectForKey:currentKey];
            if (type != nil && [type isKindOfClass:[NSString class]]) {
                NSDate *date = [NSDate date];
                NSTimeInterval timeVal = [date timeIntervalSince1970];
                [dataString appendFormat:@"; filename=\"%d.png\"\r\nContent-Type: %@\r\n\r\n", (long)timeVal, type];
                [postBody appendData:[dataString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO]];
                if ([currentValue isKindOfClass:[NSData class]]) {
                    [postBody appendData:currentValue];
                }
                [dataString appendString:@"\r\n"];
                [postBody appendData:[dataString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO]];
            } else {                                
                [dataString appendFormat:@"\r\n\r\n%@\r\n", currentValue];
                [postBody appendData:[dataString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO]];
            }
            
                                    
			//[postBody appendData:[[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", boundary, currentKey, currentValue] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO]];
		}
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO]];
	}
	[req setHTTPBody:postBody];
    NSString *len = [NSString stringWithFormat:@"%d", postBody.length];
    [req setValue:len forHTTPHeaderField:@"Content-Length"];
    [postBody release];
    
    //debug
    NSString *s = [[NSString alloc] initWithData:postBody encoding:NSASCIIStringEncoding];
    NSLog(@"multiPart: %@", s);
	
	curConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	
	
	
	if (curConnection) {
		receivedData = [[NSMutableData alloc] init];
	} else {
		result = API_RESULT_INTERNET_ERROR;
		[self setErrString:@"Internet connection is not available."];
		[delegate onAPICallFinishedUpdate:self];
	}
}

- (void)cancel {
    [curConnection cancel];
    [curConnection release], curConnection = nil;	
    [receivedData release], receivedData = nil;
	result = API_RESULT_CANCELED;
	[self setErrString:@"Connection stopped by user."];
    NSLog(@"cancel");
	[delegate onAPICallFinishedUpdate:self];
}

- (void)setErrString:(NSString *)str {
	[errResult release], errResult = nil;
	errResult = [str retain];
}

@end
