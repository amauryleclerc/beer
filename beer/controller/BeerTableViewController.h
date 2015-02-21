//
//  BeerTableViewController.h
//  beer
//
//  Created by momo on 08/02/2015.
//  Copyright (c) 2015 momo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyleB.h"

@interface BeerTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *beers;
@property (nonatomic, strong) StyleB *style;

@end
