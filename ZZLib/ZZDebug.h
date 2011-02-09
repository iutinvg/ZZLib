/**
 * Debugging tools.
 *
 * ZZLOG(@"formatted log text %d", param1);
 * Print the given formatted text to the log.
 *
 * ZZLOGRECT(rect);
 * Print the rectangle.
 */

// The general purpose logger. This ignores logging levels.
#ifdef DEBUG
	#define ZZLOG(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
	#define ZZLOGRECT(rect) ZZLOG(@"%f x %f - %f x %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
	#define ZZLOGPOINT(point) ZZLOG(@"%f x %f", point.x, point.y)
	#define ZZLOGSIZE(size) ZZLOG(@"%f x %f", size.width, size.height)
#else
	#define ZZLOG(xx, ...) ((void)0)
	#define ZZLOGRECT(rect) ((void)0)
	#define ZZLOGPOINT(point) ((void)0)
	#define ZZLOGSIZE(size) ((void)0)
#endif
