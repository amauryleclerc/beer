//
//  StyleTableViewController.h
//  beer
//
//  Created by momo on 20/02/2015.
//  Copyright (c) 2015 momo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryB.h"

@interface StyleTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *styles;

@property (nonatomic, strong) CategoryB *category;

@end
