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

@interface MovieListViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation MovieListViewCell

- (void)configureCellWithMovieObject:(MovieObject *)movieObject {
    self.titleLabel.text = SafeStr(movieObject.title);
    self.yearLabel.text = SafeStr(movieObject.year);
    self.ratingLabel.text = SafeStr(movieObject.rating);
    
    //Image
    NSString *posterURLString = movieObject.poster.urls.w92;
    NSURL *url = [NSURL URLWithString:posterURLString];
    if (url) {
//        [self.posterImageView setImageWithURL:url usingActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        [self.posterImageView setImageWithURL:url placeholderImage:nil options:(SDWebImageCacheMemoryOnly) usingActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    }else {
        self.posterImageView.image = nil;
    }
}

@end