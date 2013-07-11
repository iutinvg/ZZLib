/**
 A collection of functions to create URLs.

 Workflow:
 
 - set base URL (in application delegate)
 - optionally set persistent parameters to use in every request (useful of you use some
   sort of API where you always need to pass a secret-key or something)
 - set parameters for particular request
 - generate URL
 - use the URL to make request

 Usage example:
	 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
		 // params to add to every request
		 NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
						 @"4a6b9d8c09da17219420854c90c0776a", @"api_key",
						 @"json", @"format",
						 @"1", @"nojsoncallback",
						 nil];
		 [ZZURLHelper startWithBaseURL:@"http://api.flickr.com/services/rest/" persistentParams:params];
		 // ...
	 }

     // Somewhere in your view-controller:
	 - (void)createRequest {
		 NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
						 @"flickr.photos.search", @"method",
						 @"flower", @"text",
						 nil];
		 // don't forget a number of persistent params will also be added
		 NSString* urlString = [ZZURLHelper urlForMethod:@"" params:params];
		 ZZLOG(@"flickr url: %@", urlString);

		 [super createRequest];
		 self.request = [[ZZJSONRequest alloc] initWithDelegate:self];
		 [self.request get:urlString];
	 }
 
 You may also want to use [ZZJSONRequest persistemtHeader:] method.
 */
@interface ZZURLHelper : NSObject

/**
 Setup base URL for your API.
 
 @param url URL string
 @param params persistent parameters dictionary
 */
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
