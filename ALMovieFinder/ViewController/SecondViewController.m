//
//  SecondViewController.m
//  ALMovieFinder
//
//  Created by ALLENMAC on 2015/3/6.
//  Copyright (c) 2015年 AllenLee. All rights reserved.
//

#import "SecondViewController.h"
#import "FBTweakStore.h"
#import "FBTweakViewController.h"

@interface SecondViewController () <FBTweakViewControllerDelegate>

- (IBAction)presentTweaks:(id)sender;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tweakViewControllerPressedDone:(FBTweakViewController *)tweakViewController {
    [tweakViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)presentTweaks:(id)sender {
    FBTweakStore *store = [FBTweakStore sharedInstance];
    FBTweakViewController *viewController = [[FBTweakViewController alloc] initWithStore:store];
    viewController.tweaksDelegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
}

@end
