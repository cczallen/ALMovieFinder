//
//  MovieListViewController.m
//  ALMovieFinder
//
//  Created by ALLENMAC on 2015/3/6.
//  Copyright (c) 2015年 AllenLee. All rights reserved.
//

#import "MovieListViewController.h"

@implementation MovieListViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseTableViewCell cellReuseIdentifier]];
    
    NSString *text = [NSString stringWithFormat:@"%li", indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

@end
