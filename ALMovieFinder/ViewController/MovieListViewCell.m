//
//  MobieListViewCell.m
//  ALMovieFinder
//
//  Created by ALLENMAC on 2015/3/6.
//  Copyright (c) 2015年 AllenLee. All rights reserved.
//

#import "MovieListViewCell.h"
#import "MovieObject.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@implementation MovieListViewCell

- (void)dealloc {
    if (&UIContentSizeCategoryDidChangeNotification != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
}

- (void)awakeFromNib {
    self.posterImageView.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
    if (&UIContentSizeCategoryDidChangeNotification != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextSizeChangeNotification) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
}

- (void)configureCellWithMovieObject:(MovieObject *)movieObject {
    [self configureCellWithMovieObject:movieObject andSearchText:nil];
}

- (void)configureCellWithMovieObject:(MovieObject *)movieObject andSearchText:(NSString *)searchText {
    NSString *year = ([movieObject.year integerValue] < 1880)? @"" : SafeStr(movieObject.year);
    self.yearLabel.text = year;
    self.ratingLabel.text = SafeStr(movieObject.rating);
    
    //Image
    NSString *posterURLString = movieObject.poster.urls.w92;
    NSURL *url = [NSURL URLWithString:posterURLString];
    if (url) {
        self.posterImageView.layer.borderWidth = 0.5;
        [self.posterImageView setImageWithURL:url placeholderImage:nil options:(SDWebImageCacheMemoryOnly) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.posterImageView.layer.borderWidth = 0;
        } usingActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    }else {
        self.posterImageView.image = nil;
    }
    
    //Title (Highlight)
    self.titleLabel.text = SafeStr(movieObject.title);
    BOOL highlight = UITweakValue(@"Highlight Keyword", YES);
    if (highlight && searchText) {
        UILabel *label = self.titleLabel;
        NSRange range = [label.text rangeOfString:searchText options:(NSCaseInsensitiveSearch)];
        BOOL find = range.location != NSNotFound;
        if (find) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
            //Clear Color
            if (range.location != 0) {
                NSRange leftClearRange = NSMakeRange(0, range.location);
                [attributedString addAttributes:@{ NSBackgroundColorAttributeName : [UIColor clearColor] } range:leftClearRange];
            }
            //Highlighted Color
            UIColor *highlightedColor = [UIColor colorWithRed:1.000 green:1.000 blue:0.598 alpha:1.000];
            [attributedString addAttributes:@{ NSBackgroundColorAttributeName : highlightedColor } range:range];
            
            label.attributedText = attributedString;
        }
    }    
}

- (void)handleTextSizeChangeNotification {
    UIFont *dynamicFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.titleLabel.font = dynamicFont;
    self.yearLabel.font = dynamicFont;
    self.ratingLabel.font = dynamicFont;
}

@end
