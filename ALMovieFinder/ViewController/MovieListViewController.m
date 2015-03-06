//
//  MovieListViewController.m
//  ALMovieFinder
//
//  Created by ALLENMAC on 2015/3/6.
//  Copyright (c) 2015年 AllenLee. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieObject.h"
#import "MovieListViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <EXPhotoViewer.h>
#import <JDStatusBarNotification/JDStatusBarNotification.h>

static NSString * const tweakIDForQueryID = @"Query String";

@interface MovieListViewController ()

@property (nonatomic, strong) AFHTTPRequestOperation *currentRequestOperation;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, weak) MovieObject *currentMovieObject;
@property (copy, nonatomic) NSString *currentSearchText;

- (void)reloadDataByQueryString:(NSString *)queryString;

//IB
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;
- (IBAction)reloadButtonAction:(id)sender;

@end

@implementation MovieListViewController

//override
- (void)reloadData {
    [self reloadDataByQueryString:self.currentSearchText];
    
    FBTweakStore *store = [FBTweakStore sharedInstance];
    FBTweakCategory *category = [store tweakCategoryWithName:@"Preferences"];
    FBTweakCollection *collection = [category tweakCollectionWithName:@"API"];
    FBTweak *tweak = [collection tweakWithIdentifier:tweakIDForQueryID];
    tweak.currentValue = self.currentSearchText;
}

- (void)reloadDataByQueryString:(NSString *)queryString {
    void(^finalBlock)() = ^() {
        self.currentRequestOperation = nil;
        [SVProgressHUD dismiss];
    };
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    self.currentRequestOperation =
    [MovieObject fetchMoviesByQueryString:queryString success:^(AFHTTPRequestOperation *operation, NSArray *movieObjects) {
        //Clear
        self.movies = nil;
        self.currentMovieObject = nil;
        [self.tableView reloadData];
        //Set
        dispatchAfter(0.5, ^{
            self.movies = movieObjects;
            [self.tableView reloadDataWithRowAnimation:(UITableViewRowAnimationFade)];
            // TODO: Empty Page?
            finalBlock();
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        finalBlock();
    }];
}


#pragma mark - View Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupSearchBar];
    [self reloadData];
}

- (void)setupTableView {
    self.tableView.contentInsetTop = 8;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupSearchBar {
    FBTweak *tweak = [[FBTweak alloc] initWithIdentifier:tweakIDForQueryID];
    tweak.name = tweakIDForQueryID;
    tweak.defaultValue = @"hobbit";
    FBTweakStore *store = [FBTweakStore sharedInstance];
    FBTweakCategory *category = [store tweakCategoryWithName:@"Preferences"];
    FBTweakCollection *collection = [category tweakCollectionWithName:@"API"];
    [collection addTweak:tweak];
    
    NSString *queryString = (tweak.currentValue)? tweak.currentValue : tweak.defaultValue;
    self.searchBar.text = queryString;
    self.currentSearchText = queryString;
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
    MovieListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MovieListViewCell cellReuseIdentifier]];
    
    NSInteger myRow = indexPath.row;
    MovieObject *movieObject = self.movies[myRow];
    [cell configureCellWithMovieObject:movieObject andSearchText:self.currentSearchText];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MovieListViewCell *cell = (MovieListViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger myRow = indexPath.row;
    MovieObject *movieObject = self.movies[myRow];
    NSString *posterURLString = movieObject.poster.urls.w500;
    NSURL *url = [NSURL URLWithString:posterURLString];
    if (url) {
        self.currentMovieObject = movieObject;
        [UIView animateWithDuration:0.4 animations:^{
            cell.posterImageView.alpha = 0.2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                cell.posterImageView.alpha = 1;
            }];
            [cell.posterImageView setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if ([self.currentMovieObject isEqual:movieObject]) {
                    [EXPhotoViewer showImageFrom:cell.posterImageView];
                }
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        }];
    }

}


#pragma mark - Actions
- (IBAction)reloadButtonAction:(id)sender {
    [self reloadData];
}


#pragma mark - <UISearchBarDelegate>
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *queryString = searchBar.text;
    if (queryString) {
        self.currentSearchText = queryString;
        [searchBar endEditing:YES];
        [self reloadData];
    }
}

@end
