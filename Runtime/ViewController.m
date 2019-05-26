//
//  ViewController.m
//  Runtime
//
//  Created by admin on 2019/5/26.
//  Copyright © 2019 admin. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[Person new] sendMessage:@"hello"];
}


@end
