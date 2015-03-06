//
//  MobieListViewCell.h
//  ALMovieFinder
//
//  Created by ALLENMAC on 2015/3/6.
//  Copyright (c) 2015年 AllenLee. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MovieObject;

@interface MovieListViewCell : BaseTableViewCell

- (void)configureCellWithMovieObject:(MovieObject *)movieObject;

@end
