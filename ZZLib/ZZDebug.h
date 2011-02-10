/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

/**
 * Debugging tools.
 *
 * ZZLOG(@"formatted log text %d", param1);
 * Print the given formatted text to the log.
 *
 * Tips:
 * - to enable logging just define DEBUG macros for Debug configuration 
 *   of your project: select a Target, click Info button, select Build tab,
 *   select Debug configuration, find Preprocessor Macros, add DEBUG
 * - thus logging will work for Debug configuration, Release/Distribution 
 *   configurations will be silent; if you'd like to log something in
 *   all configurations then just use NSLog()
 */

// The general purpose logger. This ignores logging levels.
#ifdef DEBUG
	#define ZZLOG(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
	#define ZZLOG(xx, ...) ((void)0)
#endif
