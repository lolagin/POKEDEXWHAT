//
//  JasonViewController.m
//  JeffreyFeed
//
//  Created by Jeffrey C Rosenthal on 3/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "JasonViewController.h"
#import "Pokemon.h"
#import "PokeStore.h"
#import "PokeDetailsViewController.h"


@interface JasonViewController ()

//ADD MOAR SESSION TASKS-- LOCAL DEX FILLER -> INDIVIDUAL POKEMON PASSD TO DETAIL VC
//@property (strong, nonatomic) NSURLSession *session;
//@property (strong, nonatomic) NSArray *localDex;




@end
@implementation JasonViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pokeback"]];
//    CGRect selfie = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.width);
//    UIImageView *viewie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pokeback"]];
//    viewie.frame = selfie;
//    [self.view addSubview:viewie];
    
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pokeback"]];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[PokeStore sharedStore] allPokemon] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSDictionary *pokemon = [[PokeStore sharedStore] allPokemon][indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"#%i, %@",indexPath.row + 1, [pokemon[@"name"] description]];
    cell.backgroundColor = [UIColor clearColor];
//    cell.detailTextLabel =
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *pokemon = [[PokeStore sharedStore] allPokemon][indexPath.row];

    NSString *pokestring =  [pokemon[@"resource_uri"] description];
    [[PokeStore sharedStore] fetchDetailPokemon:pokestring];
    PokeDetailsViewController *pokeDetailViewController = [[PokeDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:pokeDetailViewController
                                     animated:YES];

}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
        self.navigationItem.title = @"PoKeDeX ^_^";
        [PokeStore sharedStore];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeLoadedRefresh) name:@"StoreLoadedRefresh" object:nil];
        

    }
    return self;
    }


-(void)storeLoadedRefresh {
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


//
//-(void)fetchFeed {
//    NSString *requestString = @"http://pokeapi.co/api/v1/pokedex/1/";
//    NSURL *url = [NSURL URLWithString:requestString];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    
//    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSDictionary *pokeDex = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        self.localDex = pokeDex[@"pokemon"];
//        NSLog(@"%@",self.localDex);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    
//    
//    }];
//    [dataTask resume];
//}
@end
