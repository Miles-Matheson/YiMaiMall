//
//  PhoneAddController.m
//  MurphysLaw
//
//  Created by Miles on 2017/4/12.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "PhoneAddController.h"

@interface PhoneAddController ()
{
    NSMutableArray *nameArr;
    NSMutableArray *numberArr;
}
@end

@implementation PhoneAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aTableView.delegate  = self;
    self.aTableView.dataSource = self;
    
    self.navigationItem.title = @"选取国家";
    
   NSArray *listArr =  [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"usersList" ofType:@"plist"]] objectAtIndex:0];
    
    
    nameArr = [NSMutableArray array];
    numberArr = [NSMutableArray array];
    
    for (NSArray *dataArr in listArr) {
        
         [nameArr addObject:dataArr[0]];
        
         [numberArr addObject:dataArr[1]];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return nameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.phoneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (self.phoneCell == nil ) {
        self.phoneCell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    self.phoneCell.textLabel.text = [nameArr objectAtIndex:indexPath.row];
    
    self.phoneCell.detailTextLabel.text = [numberArr objectAtIndex:indexPath.row];
   return  self.phoneCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString *info = [NSString stringWithFormat:@"%@%@",[nameArr objectAtIndex:indexPath.row],[numberArr objectAtIndex:indexPath.row]];
    
    NSString *info = [NSString stringWithFormat:@"%@",[numberArr objectAtIndex:indexPath.row]];
    
    if (_itemClickCallBack) {
        _itemClickCallBack(info);
    }
}

@end
