//
//  PokeDetailsViewController.m
//  JeffreyFeed
//
//  Created by Jeffrey C Rosenthal on 4/1/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "PokeDetailsViewController.h"

@interface PokeDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pokeNameLabel;






@end

@implementation PokeDetailsViewController {
//    NSString *pokeName;
//    NSInteger attack;
//    NSInteger defense;
//    NSArray *pokeMoves;
    Pokemon *pokemon;
}
-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailLoadedResetReveal) name:@"DetailLoadedResetReveal" object:nil];
//    UIImageView *coverView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    coverView.image = [UIImage imageNamed:@"pokemonloadiphone"];
//    [self.view addSubview:coverView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)detailLoadedResetReveal {

    pokemon = [[PokeStore sharedStore]detailPokemon];
    [self refreshLabels];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
}

-(void)refreshLabels{
    self.pokeNameLabel.text = pokemon.name;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
