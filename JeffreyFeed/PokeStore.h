//
//  PokeStore.h
//  JeffreyFeed
//
//  Created by Jeffrey C Rosenthal on 3/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"



//^^^ is like self.whatever = sharedstore] detailPokemon]


@interface PokeStore : NSObject

@property(nonatomic, readonly, copy) NSArray *allPokemon;
@property(strong, nonatomic)Pokemon *detailPokemon;

-(void)fetchDetailPokemon:(NSString *)pokeAppend;

+ (instancetype)sharedStore;
//PDVC calls detailPopulate:(nsint)pokemon, fetch from store on viewwillappear



@end
