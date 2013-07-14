/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZURLHelper.h"
#import "ZZDebug.h"

static NSDictionary* persistentParams;
static NSString* baseURL;

@implementation ZZURLHelper

+ (void)startWithBaseURL:(NSString *)url persistentParams:(NSDictionary *)params
{
    baseURL = url;
    [ZZURLHelper persistentParams:params];
}

+ (NSDictionary*)persistentParams:(NSDictionary *)params
{
    if (params!=nil) {
        persistentParams = params;
    }
    return persistentParams;
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
    
    ZZLOG(@"create URL: %@", method);
    
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
