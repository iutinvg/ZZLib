/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#ifdef DEBUG

#import "ZZJSONRequest.h"

#warning ACCEPT INSECURE SERVER CONNECTIONS, ENSURE IT IS DISABLED FOR PRODUCTION

@interface ZZJSONRequest (ZZSelfSignedSSL)

@end

#endif