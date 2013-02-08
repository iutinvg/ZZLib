#import "ZZURLHelper.h"

static NSDictionary* persistentParams;
static NSString* baseURL;

@implementation ZZURLHelper

+ (void)startWithBaseURL:(NSString *)url persistentParams:(NSDictionary *)params
{
    baseURL = url;
    persistentParams = params;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*)urlForMethod:(NSString*)action params:(NSDictionary*)dict
{
    NSMutableDictionary* p = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    [p addEntriesFromDictionary:persistentParams];
    
    return [ZZURLHelper urlForMethod3:action params:p];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*)urlForMethod3:(NSString*)action params:(NSDictionary*)dict {
    NSMutableString* method = [[NSMutableString alloc] initWithFormat:@"%@%@", baseURL, action];
    
    BOOL veryFirst = YES;
    for (NSString* key in [dict allKeys]) {
        NSString* sep = veryFirst ? @"?" : @"&";
        [method appendFormat:@"%@%@=%@", sep, key, [ZZURLHelper encode:[dict objectForKey:key]]];
        veryFirst = NO;
    }
    
    return method;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString*)encode:(NSString*)value {
    NSString* result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (CFStringRef)value,
                                                                          NULL,
                                                                          CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                          kCFStringEncodingUTF8);
    return result;
}

@end
