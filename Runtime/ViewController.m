//
//  ViewController.m
//  Runtime
//
//  Created by admin on 2019/5/26.
//  Copyright © 2019 admin. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NewPerson.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, strong) Person *p1;
@property (nonatomic, strong) Person *p2;

@property (nonatomic, strong) NewPerson *np1;
@property (nonatomic, strong) NewPerson *np2;

@end

@implementation ViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self sendMessage];
    
//    [self methodExchange];
    
//    [self systemKVO];
}

- (void)customKVO {
    _np1 = [NewPerson new];
    _np2 = [NewPerson new];
    
    _np2.name = @"Kody";
    NSLog(@"监听之前---p1:%p, p2:%p", [_np1 methodForSelector:@selector(setName:)], [_np2 methodForSelector:@selector(setName:)]);
    [_np1 zf_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _np1.name = @"Tom";
    NSLog(@"监听之后---p1:%p, p2:%p", [_np1 methodForSelector:@selector(setName:)], [_np2 methodForSelector:@selector(setName:)]);
}

- (void)systemKVO {
    _p1 = [Person new];
    _p2 = [Person new];
    
    _p2.name = @"Kody";
    NSLog(@"监听之前---p1:%p, p2:%p", [_p1 methodForSelector:@selector(setName:)], [_p2 methodForSelector:@selector(setName:)]);
    [_p1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _p1.name = @"Tom";
    NSLog(@"监听之后---p1:%p, p2:%p", [_p1 methodForSelector:@selector(setName:)], [_p2 methodForSelector:@selector(setName:)]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"change == %@", change);
}

- (void)sendMessage {
    // 消息发送机制方法调用
    [[Person new] sendMessage:@"hello"];
}

- (void)methodExchange {
//    _dataArray = @[@"hello1", @"hello2", @"hello3", @"hello4", @"hello5"];
    _dataArray = @[];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _dataArray.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = _dataArray[indexPath.row];
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

@end
