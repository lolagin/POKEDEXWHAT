//
//  Pokemon.h
//  JeffreyFeed
//
//  Created by Jeffrey C Rosenthal on 3/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pokemon : NSObject
@property (strong, nonatomic)NSString *name;
@property (nonatomic)NSUInteger dexNumber;
@property (strong, nonatomic)NSString *typeOne;
@property (strong, nonatomic)NSString *typeTwo;
@property (strong, nonatomic)NSArray *moves;
@property (nonatomic)NSUInteger attack;
@property (nonatomic)NSUInteger defense;

@end
