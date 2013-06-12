/**
 A collection of functions to create URLs.
 
 Workflow:
 - set base URL (in application delegate)
 - optionally set persistent parameters to use in every request (useful of you use some
   sort of API where you always need to pass a secret-key or something)
 - set parameters for particular request
 - generate URL
 - use the URL to make request
 */
@interface ZZURLHelper : NSObject

+ (void)startWithBaseURL:(NSString*)url persistentParams:(NSDictionary*)params;

/**
 Sets parameters which will be added to query string part of all URLs.
 
 @param params dictionary to use as key-value pair in query string.
 */
+ (NSDictionary*)persistentParams:(NSDictionary*)params;
+ (NSString*)urlForMethod:(NSString*)method params:(NSDictionary*)dict;
+ (NSString*)urlForMethod3:(NSString*)action params:(NSDictionary*)dict;
+ (NSString*)encode:(NSString*)value;

@end