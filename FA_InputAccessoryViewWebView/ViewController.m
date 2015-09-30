//
//  ViewController.m
//  FA_InputAccessoryViewWebView
//
//  Created by Pierre Laurac on 9/29/15.
//  Copyright © 2015 Pierre Laurac. All rights reserved.
//

#import "ViewController.h"
#import "FA_InputAccessoryWebView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet FA_InputAccessoryWebView *webview;


@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 45)];
    [view setBackgroundColor:[UIColor redColor]];
    [self.webview changeAccessoryView:view];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://google.com"]];
    [self.webview loadRequest:request];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
