//
//  MovieListViewController.m
//  ALMovieFinder
//
//  Created by ALLENMAC on 2015/3/6.
//  Copyright (c) 2015年 AllenLee. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieObject.h"
#import <SVProgressHUD.h>
#import <ALUtilities.h>

@interface MovieListViewController ()

@property (nonatomic, strong) AFHTTPRequestOperation *currentRequestOperation;
@property (nonatomic, strong) NSArray *movies;

//IB
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;
- (IBAction)reloadButtonAction:(id)sender;

@end

@implementation MovieListViewController

//override
- (void)reloadData {
    void(^finalBlock)() = ^() {
        self.currentRequestOperation = nil;
    };
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    self.currentRequestOperation =
    [MovieObject fetchMoviesByQueryString:@"hobbit" success:^(AFHTTPRequestOperation *operation, NSArray *movieObjects) {
        self.movies = movieObjects;
        [self.tableView reloadData];
        // TODO: Empty Page?
        [SVProgressHUD dismiss];
        finalBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        finalBlock();
    }];
}

#pragma mark - Custom Setters
- (void)setCurrentRequestOperation:(AFHTTPRequestOperation *)currentRequestOperation {
    if (![_currentRequestOperation isEqual:currentRequestOperation]) {
        _currentRequestOperation = currentRequestOperation;
    }
    self.reloadButton.enabled = (self.currentRequestOperation == nil);
}

#pragma mark - UITableView DataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseTableViewCell cellReuseIdentifier]];
    
    NSInteger myRow = indexPath.row;
    MovieObject *movie = self.movies[myRow];
    NSString *text = [NSString stringWithFormat:@"%li. %@", (myRow+1), SafeStr(movie)];
    cell.textLabel.text = text;
    
    return cell;
}


#pragma mark - Actions
- (IBAction)reloadButtonAction:(id)sender {
    [self reloadData];
}

@end
