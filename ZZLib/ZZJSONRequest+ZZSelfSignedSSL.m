/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#ifdef DEBUG

#import "ZZJSONRequest+ZZSelfSignedSSL.h"

@implementation ZZJSONRequest (ZZSelfSignedSSL)

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    ZZLOG(@"------------------------------------898 67987 9 798 7098 7098 709 87098 7098709 808 7");
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    ZZLOG(@"------------------------------------898 67987 9 798 7098 7098 709 87098 7098709 808 7");
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
         forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    
    ZZLOG(@"------------------------------------898 67987 9 798 7098 7098 709 87098 7098709 808 7");
}

@end

#endif