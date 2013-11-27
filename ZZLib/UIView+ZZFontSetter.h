/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>

/**
 Font setter category.
 
 The idea is stolen from http://stackoverflow.com/a/17051660/444966
 */
@interface UIView (ZZFontSetter)

/**
 Set font recusrsively for all subview of the view.
 
 Keeps the font size. Thus the font size of given parameters will be ignored. Very useful to 
 customize fonts for the view created on spot: table-cells and others.
 
 Usage example:
    UIFont *regular = [UIFont fontWithName:@"ProximaNova-Light" size:9];
    UIFont *bold = [UIFont fontWithName:@"ProximaNova-Semibold" size:9];
    [cell setAllFonts:regular bold:bold];
 
 @param regular regular font replacer
 @param bold bold font replacer
 */
- (void)setAllFonts:(UIFont*)regular bold:(UIFont*)bold;

@end
