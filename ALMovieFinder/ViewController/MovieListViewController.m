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

static NSString * const tweakIDForQueryID = @"Query String";

@interface MovieListViewController ()

@property (nonatomic, strong) UILabel *tableFooterLabel;
@property (nonatomic, strong, setter=setCurrentRequestOperation:) AFHTTPRequestOperation *currentRequestOperation;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, weak) MovieObject *currentMovieObject;
@property (copy, nonatomic) NSString *currentSearchText;

- (void)reloadData;
- (void)reloadDataByQueryString:(NSString *)queryString;
- (void)setupTableView;
- (void)setupSearchBar;
- (UIFont *)getDynamicFontForSearchBar;
- (void)handleTextSizeChangeNotification;
- (void)resetFooterView;
- (FBTweak *)getTweakForQuery;

//IB
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;
- (IBAction)reloadButtonAction:(id)sender;
- (IBAction)tryHobbitAction:(id)sender;

@end

@implementation MovieListViewController

//override
- (void)reloadData {
    [self reloadDataByQueryString:self.currentSearchText];
}

- (void)reloadDataByQueryString:(NSString *)queryString {
    void(^removeOperation)() = ^() {
        self.currentRequestOperation = nil;
    };
    void(^clear)() = ^() {
        self.movies = nil;
        self.currentMovieObject = nil;
        [self.tableView reloadData];
    };
    
    if (self.currentRequestOperation) {
        [self.currentRequestOperation cancel];
    }
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    self.currentRequestOperation =
    [MovieObject fetchMoviesByQueryString:queryString success:^(AFHTTPRequestOperation *operation, NSArray *movieObjects) {
        //Clear
        clear();
        //Set
        dispatchAfter(0.5, ^{
            self.movies = movieObjects;
            [self.tableView reloadDataWithRowAnimation:(UITableViewRowAnimationFade)];
            [SVProgressHUD dismiss];
            removeOperation();
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.isCancelled) {
            return;
        }
        NSString *message;
        if (operation.response.statusCode == 404) { //Resource not found
            message = operation.responseObject[@"error"][@"message"];
            [SVProgressHUD showInfoWithStatus:message];
            removeOperation();
            dispatchAfter(1.2, ^{
                clear();
            });
        }else {
            message = error.localizedDescription;
            [SVProgressHUD showErrorWithStatus:message];
            removeOperation();
        }
    }];
    
    FBTweak *tweak = [self getTweakForQuery];
    tweak.currentValue = self.currentSearchText;
}


#pragma mark - View Cycle
- (void)dealloc {
    if (&UIContentSizeCategoryDidChangeNotification != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchBar];
    [self setupTableView];
    [self reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    FBTweakStore *store = [FBTweakStore sharedInstance];
    FBTweakCategory *category = [store tweakCategoryWithName:@"Preferences"];
    FBTweakCollection *collection = [category tweakCollectionWithName:@"API"];
    FBTweak *tweak = [collection tweakWithIdentifier:tweakIDForQueryID];
    if (![tweak.currentValue isEqualToString:[self.searchBar.text getTrimmedVal]]) {
        self.searchBar.text = tweak.currentValue;
        self.currentSearchText = self.searchBar.text;
        [self reloadData];
    }
}

- (void)setupTableView {
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableFooterLabel = [[UILabel alloc] init];
    self.tableFooterLabel.backgroundColor = [UIColor colorWithRed:0.987 green:1.000 blue:0.948 alpha:1.000];
    self.tableFooterLabel.height = 44;
    self.tableFooterLabel.textAlignment = NSTextAlignmentCenter;
    self.tableFooterLabel.textColor = [UIColor grayColor];
    self.tableFooterLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.tableView.tableFooterView = self.tableFooterLabel;
}

- (void)setupSearchBar {
    UIFont *dynamicFont = [self getDynamicFontForSearchBar];
    [[UITextField appearanceWhenContainedIn: [UISearchBar class], nil] setFont:dynamicFont];
    if (&UIContentSizeCategoryDidChangeNotification != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextSizeChangeNotification) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    
    FBTweak *tweak = [self getTweakForQuery];
    NSString *queryString = (tweak.currentValue)? tweak.currentValue : tweak.defaultValue;
    self.searchBar.text = queryString;
    self.currentSearchText = queryString;
}

- (UIFont *)getDynamicFontForSearchBar {
    UIFont *dynamicFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    CGFloat maxSize = self.searchBar.height -4;
    if (dynamicFont.pointSize > maxSize) {
        dynamicFont = [UIFont systemFontOfSize:maxSize];
    }
    
    return dynamicFont;
}

- (void)handleTextSizeChangeNotification {
    UIFont *dynamicFont = [self getDynamicFontForSearchBar];
    for (UIView *view in [[self.searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [(UITextField *)view setFont:dynamicFont];
        }
    }
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
    NSInteger number = self.movies.count;
    [self resetFooterView];
    if (number == 0 && self.currentRequestOperation == nil) {
        number = 1;
    }
    
    return number;
}

- (void)resetFooterView {
    NSInteger number = self.movies.count;
    self.tableFooterLabel.text = [NSString stringWithFormat:@"%li items", number];
    self.tableFooterLabel.hidden = (number == 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 4;
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.movies.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:[MovieListViewCell cellReuseIdentifier]];
        
        NSInteger myRow = indexPath.row;
        MovieObject *movieObject = self.movies[myRow];
        [(MovieListViewCell *)cell configureCellWithMovieObject:movieObject andSearchText:self.currentSearchText];
        
    }else {
        static NSString * const emptyCellID = @"EmptyCell";
        cell = [tableView dequeueReusableCellWithIdentifier:emptyCellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!self.movies.count) {
        [self tryHobbitAction:nil];
        return;
    }
    
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
    [self.searchBar endEditing:YES];
}

- (IBAction)tryHobbitAction:(id)sender {
    NSString *queryString = @"hobbit";
    self.searchBar.text = queryString;
    self.currentSearchText = queryString;
    [self reloadData];
}


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = [searchBar.text getTrimmedVal];
    NSString *queryString = searchBar.text;
    if (queryString) {
        self.currentSearchText = queryString;
        [searchBar endEditing:YES];
        [self reloadData];
    }
}


#pragma mark -
- (FBTweak *)getTweakForQuery {
    FBTweakStore *store = [FBTweakStore sharedInstance];
    FBTweakCategory *category = [store tweakCategoryWithName:@"Preferences"];
    FBTweakCollection *collection = [category tweakCollectionWithName:@"API"];
    FBTweak *tweak = [collection tweakWithIdentifier:tweakIDForQueryID];
    if (!tweak) {
        tweak = [[FBTweak alloc] initWithIdentifier:tweakIDForQueryID];
        tweak.name = tweakIDForQueryID;
        tweak.defaultValue = @"hobbit";
        [collection addTweak:tweak];
    }
    
    return tweak;
}

@end
