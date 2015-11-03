//
//  SetViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UIAlertViewDelegate>
{
    UITableView *_tableView;
    UIAlertView *_alertView;
    NSString *_cachData;
}
@end

@implementation SetViewController

-(void)viewWillAppear:(BOOL)animated{
    _cachData = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    _cachData = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    [self _creatAlertView];
    [self _creatTableView];
    [self _createButton];
}
-(void)_creatAlertView{
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将会清除用户信息与缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}

//创建表视图
-(void)_creatTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 208+44) style:UITableViewStylePlain ];
    [self.view addSubview:_tableView];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
}

//创建button
-(void)_createButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, _tableView.bottom+20, kScreenWidth-40, 35)];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logOutAction) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = !_isLogIn;
    [self.view addSubview:button];
}
//登出
-(void)logOutAction {
    NSLog(@"退出登录");
    //移除用户信息本地数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserImage];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kNickName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCellNumber];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMail];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //第一组加上文字和单选按钮
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"通知时声音";
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-60, 5, 30, 30)];
            switchButton.on = YES;
            [cell.contentView addSubview:switchButton];
            
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"通知时震动";
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-60, 5, 30, 30)];
            switchButton.on = YES;
            [cell.contentView addSubview:switchButton];
            
        }
    }
    
    
    if (indexPath.section==1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"清除缓存";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 5, 100, 30)];
        label.text = [NSString stringWithFormat:@"%@",_cachData];
        label.backgroundColor  = [UIColor whiteColor];
        [cell.contentView addSubview:label];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"通知";
    }
    return @"缓存";
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        [_alertView show];
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self performSelector:@selector(getPathOfCatch) withObject:nil afterDelay:0.5f];
        _cachData = @"清理中...";
        [_tableView reloadData];
        
    }
}
#pragma mark - 清理缓存
-(CGFloat)countCacheFileSize{
    //获取沙盒路径
    NSString *filePath= NSHomeDirectory();
    //查看需要清理的文件路径，进行拼接
    //@"/library/Preferences/"  本地数据
    CGFloat fileSize=0;
    NSArray *fileArray = @[@"/library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/library/Caches/com.wendan.----/",@"/library/Cookies/"];
    //    遍历拼接
    for(NSString *str in fileArray){
        NSString *file=[NSString stringWithFormat:@"%@%@",filePath,str];
        //        调用计算文件大小的方法
        fileSize+=[self getFileSize:file];
    }
    return fileSize/1024.0f/1024;
    
}
-(CGFloat)getFileSize:(NSString *)filePath{
    //文件管理类，单例
    NSFileManager *manager=[NSFileManager defaultManager];
    //获取文件数组
    NSArray *fileName=[manager subpathsAtPath:filePath];
    //遍历文件夹
    long long fileSize=0;
    for(NSString *str in fileName){
        NSString *file=[NSString stringWithFormat:@"%@/%@",filePath,str];
        NSDictionary *oneFile=[manager attributesOfItemAtPath:file error:nil];

        NSNumber *oneFileSize =oneFile[NSFileSize];
        fileSize+=[oneFileSize longLongValue];
    }
    return fileSize;
}
//获取缓存路径
-(void)getPathOfCatch{
    NSString *path = NSHomeDirectory();
    //目标文件夹
    NSArray *fileArray = @[@"/library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/library/Caches/com.wendan.----/",
                           @"/library/Cookies/"];
    
    //文件管理
    NSFileManager *manager = [NSFileManager defaultManager];
    //遍历子文件并删除
    for(NSString *str in fileArray){
        NSString *file=[NSString stringWithFormat:@"%@%@",path,str];
        //获取子文件
        NSArray *fileNames=[manager subpathsOfDirectoryAtPath:file error:nil];
        //    再次拼接子文件路径
        for(NSString *fileName in fileNames){
            NSString *oneFile=[NSString stringWithFormat:@"%@%@",file,fileName];
            [manager removeItemAtPath:oneFile error:nil];
        }
    }
    //清理完重新计算
    _cachData = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    [_tableView reloadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
