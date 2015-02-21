//
//  CategoryTableViewController.m
//  beer
//
//  Created by momo on 20/02/2015.
//  Copyright (c) 2015 momo. All rights reserved.
//

#import "CategoryTableViewController.h"
#import <RestKit/RestKit.h>
#import "CategoryB.h"
#import "StyleTableViewController.h"
#import "StyleB.h"
#import "Beer.h"

#define keyDB @"3fb832160850da3fb006f7009a11cbd2"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self configureRestKit];
    [self loadCategories];
    
}
- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://api.brewerydb.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *categoryMapping = [RKObjectMapping mappingForClass:[CategoryB class]];
    [categoryMapping addAttributeMappingsFromArray:@[@"name"]];
    [categoryMapping addAttributeMappingsFromArray:@[@"id"]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:categoryMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/categories"
                                                keyPath:@"data"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    // setup object mappings Style
    RKObjectMapping *styleMapping = [RKObjectMapping mappingForClass:[StyleB class]];
    [styleMapping addAttributeMappingsFromArray:@[@"name"]];
    [styleMapping addAttributeMappingsFromArray:@[@"id"]];
    [styleMapping addAttributeMappingsFromArray:@[@"categoryId"]];
    
    // register mappings Style with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptorStyle =
    [RKResponseDescriptor responseDescriptorWithMapping:styleMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/styles"
                                                keyPath:@"data"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // setup object mappings Beer
    RKObjectMapping *beerMapping = [RKObjectMapping mappingForClass:[Beer class]];
    [beerMapping addAttributeMappingsFromArray:@[@"name"]];
    [beerMapping addAttributeMappingsFromArray:@[@"id"]];
    [beerMapping addAttributeMappingsFromDictionary:@{ @"description": @"descriptionB" }];
    // register mappings Style with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptorBeer =
    [RKResponseDescriptor responseDescriptorWithMapping:beerMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/beers"
                                                keyPath:@"data"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptorBeer];
    
    [objectManager addResponseDescriptor:responseDescriptorStyle];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)loadCategories
{
    NSString *clientKEY = keyDB;
    
    NSDictionary *queryParams = @{@"key" : clientKEY };
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/categories"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _categories = mappingResult.array;
                                                  [self.tableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"PAS DE CATEGORIES ?': %@", error);
                                              }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"showStyle"]) {
       NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        StyleTableViewController *destViewController = segue.destinationViewController;
        destViewController.category = [_categories objectAtIndex:indexPath.row];
     

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
   return _categories.count;
    //return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    
    
    CategoryB *category = _categories[indexPath.row];
    cell.textLabel.text = category.name;
    
    
    return cell;
}


@end