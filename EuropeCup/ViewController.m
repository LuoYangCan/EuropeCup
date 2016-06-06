//
//  ViewController.m
//  EuropeCup
//
//  Created by 孤岛 on 16/6/4.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)NSArray *listGroupName;
@property (nonatomic,strong)NSDictionary *DictData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //获取数据
    self.DictData = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    NSArray *templist = [self.DictData allKeys];
    //排序
    self.listGroupName = [templist sortedArrayUsingSelector:@selector(compare:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource协议实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //获得组名
    NSString *groupName = [self.listGroupName objectAtIndex:section];
    //从字典取出数组
    NSArray *listTeams = [self.DictData objectForKey:groupName];
    return [listTeams count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Group";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //获得节
    NSUInteger section = [indexPath section];
    //获得行索引
    NSUInteger row = [indexPath row];
    //获得组名
    NSString *groupName = [self.listGroupName objectAtIndex:section];
    //取出球队的数组集合
    NSArray *listTeams = [self.DictData objectForKey:groupName];
    cell.textLabel.text = [listTeams objectAtIndex:row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.listGroupName count];
}// Default is 1 if not implemented

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *groupName= [self.listGroupName objectAtIndex:section];
    return groupName;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED{
    NSMutableArray *listTitles = [[NSMutableArray alloc]initWithCapacity:[self.listGroupName count]];
    for (NSString *item in self.listGroupName) {
        NSString *title = [item substringToIndex:1];
        [listTitles addObject:title];
    }
    return listTitles;
}
@end
