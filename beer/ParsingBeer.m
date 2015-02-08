//
//  ParsingBeer.m
//  beer
//
//  Created by momo on 07/02/2015.
//  Copyright (c) 2015 momo. All rights reserved.
//

#import "ParsingBeer.h"
#import "Beer.h"



@implementation ParsingBeer

#pragma mark - Public
- (Beer *)getTestBeer:() sender {
    
    Beer *beer = [[Beer alloc] init];
    if(beer){
        beer.name = @"bernadus";
        beer.description = @"superbiere";
    }else{
    
    }
    return beer;
}


@end
