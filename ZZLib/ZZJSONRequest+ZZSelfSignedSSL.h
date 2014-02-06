/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"

/**
 Workaround for SSL connections with self-signed certificates which are going to use
 on your staging servers.
 
 While you are on development stage, you can safely ignore the warning. However, it
 reminds you to take care of disabling the workaround when you go on production.
 
 Adhoc builds need this workaround too. Though they usually are built without `DEBUG` macro,
 but you can define macro `ADHOC` which will enable it too.
 */
@interface ZZJSONRequest (ZZSelfSignedSSL)

@end

//#endif