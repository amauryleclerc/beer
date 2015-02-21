//
//  UIViewController+BeerViewController.h
//  beer
//
//  Created by momo on 21/02/2015.
//  Copyright (c) 2015 momo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"
@interface BeerViewController : UIViewController
@property (nonatomic, strong) Beer *beer;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
