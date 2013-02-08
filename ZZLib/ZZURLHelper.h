@interface ZZURLHelper : NSObject

+ (void)startWithBaseURL:(NSString*)url persistentParams:(NSDictionary*)params;
+ (NSString*)urlForMethod:(NSString*)method params:(NSDictionary*)dict;
+ (NSString*)urlForMethod3:(NSString*)action params:(NSDictionary*)dict;
+ (NSString*)encode:(NSString*)value;

@end