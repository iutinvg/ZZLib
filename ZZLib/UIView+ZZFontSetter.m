/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "UIView+ZZFontSetter.h"

@implementation UIView (ZZFontSetter)

- (void)setAllFonts:(UIFont*)regular bold:(UIFont*)bold
{
    if ([self respondsToSelector:@selector(setFont:)]) {
        UIFont *oldFont = [self valueForKey:@"font"];
        
        UIFont *newFont;
        // for iOS6
        NSRange isBold = [[oldFont fontName] rangeOfString:@"Bold" options:NSCaseInsensitiveSearch];
        // for iOS7
        NSRange isMedium = [[oldFont fontName] rangeOfString:@"MediumP4" options:NSCaseInsensitiveSearch];
        if (isBold.location==NSNotFound && isMedium.location==NSNotFound) {
            newFont = [regular fontWithSize:oldFont.pointSize];
        } else {
            newFont = [bold fontWithSize:oldFont.pointSize];
        }
        
        // TODO: there are italic fonts also though
        
        [self setValue:newFont forKey:@"font"];
    }
    
    for (UIView *subview in self.subviews) {
        [subview setAllFonts:regular bold:bold];
    }
}

@end
