//
//  PokeStore.m
//  JeffreyFeed
//
//  Created by Jeffrey C Rosenthal on 3/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "PokeStore.h"



@interface PokeStore ()
//@property (nonatomic) Pokemon *pokemon;
@property (nonatomic) NSMutableArray *privateItems;
@property (strong, nonatomic) NSURLSession *session;


-(void)Populate;

@end

@implementation PokeStore



+ (instancetype)sharedStore
{
    static PokeStore *sharedStore;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmer calls [[BNRItemStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
            [self Populate];
    }
    return self;
}


-(void)Populate{
    self.privateItems = [[NSMutableArray alloc] init];
        NSString *requestString = @"http://pokeapi.co/api/v1/pokedex/1/";
        NSURL *url = [NSURL URLWithString:requestString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        
        NSURLSessionDataTask *dataTask =  [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *pokeDex = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.privateItems = pokeDex[@"pokemon"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StoreLoadedRefresh" object:nil];
            });
            
        }];
        [dataTask resume];
    }
    

-(void)fetchDetailPokemon:(NSString *)pokeAppend{
    self.detailPokemon = [[Pokemon alloc] init];
        NSString *requestString = [NSString stringWithFormat:@"http://pokeapi.co/%@", pokeAppend];
    
    
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask =  [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *pokemon = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.detailPokemon.name = [pokemon[@"name"] description];
        self.detailPokemon.attack = [pokemon[@"attack"] intValue];
        self.detailPokemon.defense = [pokemon[@"defense"] intValue];
        self.detailPokemon.moves = pokemon[@"moves"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DetailLoadedResetReveal" object:nil];
        });
        
    }];
    [dataTask resume];

}

- (NSArray *)allPokemon
{
    return [self.privateItems copy];
}

@end
