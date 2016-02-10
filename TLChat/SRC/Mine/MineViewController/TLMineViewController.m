//
//  TLMineViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

/*
 *  注意：该类TableView重载并增加section（0， 0）
 */

#import "TLMineViewController.h"
#import "TLMineHeaderCell.h"
#import "TLMineHelper.h"
#import "TLUserHelper.h"

#import "TLMineInfoViewController.h"
#import "TLMineSettingViewController.h"

@interface TLMineViewController ()

@property (nonatomic, strong) TLMineHelper *mineHelper;

@end

@implementation TLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我"];
    
    self.mineHelper = [[TLMineHelper alloc] init];
    self.data = self.mineHelper.mineMenuData;
    
    [self.tableView registerClass:[TLMineHeaderCell class] forCellReuseIdentifier:@"TLMineHeaderCell"];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLMineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMineHeaderCell"];
        [cell setUser:[TLUserHelper sharedHelper].user];
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
}

#pragma mark UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    return [super tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLMineInfoViewController *mineInfoVC = [[TLMineInfoViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:mineInfoVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    TLMenuItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"设置"]) {
        TLMineSettingViewController *settingVC = [[TLMineSettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:settingVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end