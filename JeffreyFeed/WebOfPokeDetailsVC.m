//
//  WebOfPokeDetailsVC.m
//  JeffreyFeed
//
//  Created by Jeffrey C Rosenthal on 4/1/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "WebOfPokeDetailsVC.h"

@implementation WebOfPokeDetailsVC

-(void)loadView{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}
-(void)setURL:(NSURL *)URL {
    _URL = URL;
    if (_URL){
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}


@end
