//
//  MyJunTuViewController.m
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "MyJunTuViewController.h"
#import "MyOrderViewController.h"
#import "LoginViewController.h"
#import "SetViewController.h"
#import "MyInfoViewController.h"
#import "AboutJunTuViewController.h"
#import "UserModel.h"
#import "MyNetWorkQuery.h"
#import "CouponViewController.h"

//http://www.juntu.com/index.php?m=app&c=member&a=info&userid=46163

@interface MyJunTuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MyJunTuViewController{
    BOOL _isLogIn;
    UIImageView *_imageView;
    UILabel *_nickname;
    UILabel *_username;
    UILabel *_enterLabel;
}
//
//-(void)viewWillAppear:(BOOL)animated{
//    //设置头像
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *userId = [defaults objectForKey:kUserID];
//    NSString *imageString = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=member&a=GetAvatar&userid=%@&size=180",userId];
//    [MyNetWorkQuery requestData:imageString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
//        NSString *imageUrl = result[@"url"];
//        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//        NSData *data = UIImageJPEGRepresentation(_imageView.image, 1);
//        [defaults setObject:data forKey:kUserImage];
//    } errorHandle:^(NSError *error) {
//        NSLog(@"error");
//    }];
//}

//读取本地数据
-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:kUserID];
    //判断用户是否登陆
    if (userId != nil) {
        _isLogIn = YES;
    }else{
        _isLogIn = NO;
    }
    //地区本地图片
    NSData *data = [defaults objectForKey:kUserImage];
    UIImage *image = [UIImage imageWithData:data];
    if(image != nil){
        _imageView.image = image;
    }else{
        _imageView.image = [UIImage imageNamed:@"200.jpg"];
    }
    //已经登陆
    if (_isLogIn) {
        _enterLabel.hidden = YES;
        _nickname.hidden = NO;
        _username.hidden = NO;
        //设置昵称
        NSString *nickName = [defaults objectForKey:kNickName];
        _nickname.text = nickName;
        //设置帐号
        NSString *userName = [defaults objectForKey:kUserName];
        _username.text = [NSString stringWithFormat:@"帐号:%@",userName];

    }else{//未登录
        _enterLabel.hidden = NO;
        _nickname.hidden = YES;
        _username.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    //隐藏导航栏返回按钮
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - UITableViewDataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一组
    if (indexPath.section == 0) {
        static NSString *identifier = @"myDataCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        //图片
        _imageView = (UIImageView *)[cell.contentView viewWithTag:100];
        //昵称
        _nickname = (UILabel *)[cell.contentView viewWithTag:101];
        //用户名
        _username = (UILabel *)[cell.contentView viewWithTag:102];
        //点击登陆lable
        _enterLabel = (UILabel *)[cell.contentView viewWithTag:103];
        return cell;
    }
    //第二组
    else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"listCell%li",indexPath.row]];
        return cell;
    }
    //第三组
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"listCell_%li",indexPath.row]];
        return cell;
    }
    
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }
    return 38;
}
//设置组头的视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 86)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, 150)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://image.juntu.com//uploadfile//2015//0914//20150914050948194.jpg"]];
        [view addSubview:imageView];
        return view;
    }else
        return nil;
}
//设置组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 86;
    }else
        return 1;
}
//点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (_isLogIn) {
            //个人资料
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            MyInfoViewController *myInfoVC = [storyBoard instantiateViewControllerWithIdentifier:@"info"];
            myInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myInfoVC animated:YES];
        }else{
            //跳转登录界面
            LoginViewController *logInVC = [[LoginViewController alloc] init];
            //获取登陆后的个人信息
            [logInVC setBlock:^(UserModel *model){
                //设置昵称
                _nickname.text = model.nickname;
                //设置帐号
                _username.text = [NSString stringWithFormat:@"账号:%@",model.username];
            }];
            [self.navigationController pushViewController:logInVC animated:YES];
        }
    }
    if (indexPath.section == 1) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [defaults objectForKey:kUserID];
        if (userId == nil) {//未登录时弹出登录提示
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有登录" message:@"请登录" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alertView.delegate = self;
            [alertView show];
        }else{//登录时显示订单、优惠券、电子券
            if (indexPath.row == 0) {
                //我的订单。
                MyOrderViewController *order = [[MyOrderViewController alloc] init];
                order.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:order animated:YES];
            }else if (indexPath.row == 1){
                CouponViewController *couponVC = [[CouponViewController alloc] init];
                couponVC.couponType = 0;
                couponVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:couponVC animated:YES];
            }else if (indexPath.row == 2){
                CouponViewController *couponVC = [[CouponViewController alloc] init];
                couponVC.couponType = 1;
                couponVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:couponVC animated:YES];
            }
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            //设置
            SetViewController *setView = [[SetViewController alloc] init];
            setView.isLogIn = _isLogIn;
            [self.navigationController pushViewController:setView animated:YES];
        }
        if (indexPath.row == 1) {
            //关于骏途
            AboutJunTuViewController *aboutJunTuVC = [[AboutJunTuViewController alloc]init];
            aboutJunTuVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutJunTuVC animated:YES];
        }
    }
}
//未登录时跳转到登录界面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
