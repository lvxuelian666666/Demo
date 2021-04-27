

//
//  SearchViewController.m
//  Demo
//
//  Created by Shelly on 10/8/19.
//  Copyright © 2019 Shelly. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self creatSubViews];

}

-(void)creatSubViews
{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //设置背景色不透明
    //设置背景不透明
    _searchController.searchBar.translucent=NO;
    _searchController.searchBar.barTintColor=[UIColor brownColor];

    //设置searchbar的边框颜色和背景颜色一致
    _searchController.searchBar.layer.borderWidth=1;
    _searchController.searchBar.layer.borderColor=[[UIColor brownColor] CGColor];
    _searchController.searchBar.placeholder=@"搜索联系人";
    _searchController.searchResultsUpdater = self;
    _searchController.definesPresentationContext = true;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44);
    _searchController.searchBar.delegate = self;
    self.navigationItem.titleView = _searchController.searchBar;
    
    
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"---%@",searchController.searchBar.text);
    
}




@end
