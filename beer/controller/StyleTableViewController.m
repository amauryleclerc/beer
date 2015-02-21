//
//  StyleTableViewController.m
//  beer
//
//  Created by momo on 20/02/2015.
//  Copyright (c) 2015 momo. All rights reserved.
//


#import "StyleTableViewController.h"
#import <RestKit/RestKit.h>
#import "StyleB.h"
#import "BeerTableViewController.h"


#define keyDB @"3fb832160850da3fb006f7009a11cbd2"

@interface StyleTableViewController ()

@end

@implementation StyleTableViewController

@synthesize category;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad: %@", category.name);

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  // [self configureRestKit];
    [self loadStyles];
    
}



- (void)loadStyles
{
    NSString *clientKEY = keyDB;
    
    NSDictionary *queryParams = @{@"key" : clientKEY };
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/styles"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSArray *allStyle =  mappingResult.array;
                                                  _styles = [[NSMutableArray alloc] init];
                                                  for (StyleB *unStyle in allStyle) {
                                                      if (unStyle.categoryId == category.id) {
                                                          [_styles addObject:unStyle];
                                            //              NSLog(@"style ': %@", unStyle.categoryId);
                                                      }
                                                 //     NSLog(@"style ': %@", unStyle.categoryId);
                                                  }
                                                  NSLog(@"style ': %lu", (unsigned long)_styles.count);
                                                  
                                                  
                                                  [self.tableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"PAS DE STYLES ?': %@", error);
                                              }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"showBeers"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BeerTableViewController *destViewController = segue.destinationViewController;
        destViewController.style = [_styles objectAtIndex:indexPath.row];
        
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return _styles.count;
    //return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StyleCell" forIndexPath:indexPath];
    
    
    
    StyleB *style = _styles[indexPath.row];
    cell.textLabel.text = style.name;
    
    
    return cell;
}
@end