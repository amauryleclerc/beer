//
//  UIViewController+BeerViewController.m
//  beer
//
//  Created by momo on 21/02/2015.
//  Copyright (c) 2015 momo. All rights reserved.
//

#import "BeerViewController.h"

@implementation BeerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameLabel.text = _beer.name;
    _descriptionLabel.text = _beer.descriptionB;
   
    
    NSURL * imageURL = [NSURL URLWithString:_beer.imageLabelURL];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
       _imageView.image =[UIImage imageWithData:imageData];

}
@end
