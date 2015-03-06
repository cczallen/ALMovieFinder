//
//  BaseTableViewCell.m
//  ALMovieFinder
//
//  Created by ALLENMAC on 2015/3/6.
//  Copyright (c) 2015年 AllenLee. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
