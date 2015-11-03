//
//  LoginViewController.m
//  我的骏途
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MyNetWorkQuery.h"
#import "UserModel.h"

@interface LoginViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIButton *_accountButton;
    UIButton *_phoneButton;
    UIImageView *_selectedView;
    UITextField *_accountTextF;
    UITextField *_passwordTextF;
    UIButton *_canSeeButton;
    UITextField *_phoneTextF;
    UITextField *_msgTextF;
    UIButton *_sendMsgButton;
}


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
    [self createViews];
}


- (void)createViews{
    //添加两个按钮
    _accountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth / 2, 38)];
    [_accountButton setTitle:@"骏途账户登录" forState:UIControlStateNormal];
    [_accountButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _accountButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_accountButton addTarget:self action:@selector(loginByAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_accountButton];
    
    _phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 64, kScreenWidth / 2, 38)];
    [_phoneButton setTitle:@"手机验证登录" forState:UIControlStateNormal];
    [_phoneButton  setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _phoneButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_phoneButton addTarget:self action:@selector(loginByPhone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_phoneButton];
    
    //选择滑块
    _selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 102, kScreenWidth/2, 2)];
    _selectedView.backgroundColor = [UIColor colorWithRed:52/255.0 green:186/255.0 blue:200/255.0 alpha:1];
    [self.view addSubview:_selectedView];
    
    //滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, 300)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //设置内容尺寸,只有内容尺寸大于视图才能滑动
    _scrollView.contentSize = CGSizeMake(kScreenWidth*2, 300);
    
    //创建子视图
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 44)];
    accountView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:accountView];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
    accountLabel.text = @"账号";
    accountLabel.textColor = [UIColor darkGrayColor];
    accountLabel.font = [UIFont systemFontOfSize:15];
    [accountView addSubview:accountLabel];
    
    _accountTextF = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, kScreenWidth - 50, 44)];
    _accountTextF.placeholder = @"用户名/手机号码";
    _accountTextF.font = [UIFont systemFontOfSize:15];
    [accountView addSubview:_accountTextF];
    
    
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 45,kScreenWidth, 44)];
    passwordView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:passwordView];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
    passwordLabel.text = @"密码";
    passwordLabel.textColor = [UIColor darkGrayColor];
    passwordLabel.font = [UIFont systemFontOfSize:15];
    [passwordView addSubview:passwordLabel];
    
    _passwordTextF = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, kScreenWidth - 50, 44)];
    _passwordTextF.placeholder = @"请输入密码";
    _passwordTextF.font = [UIFont systemFontOfSize:15];
    _passwordTextF.secureTextEntry = YES;
    [passwordView addSubview:_passwordTextF];
    
    _canSeeButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-60, 17, 25, 10)];
    [_canSeeButton setBackgroundImage:[UIImage imageNamed:@"neye.png"] forState:UIControlStateNormal];
    [_canSeeButton addTarget:self action:@selector(canSeeAction:) forControlEvents:UIControlEventTouchUpInside];
    [passwordView addSubview:_canSeeButton];
    
    UIButton *accountLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 35)];
    [accountLoginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    
    UILabel *accountLoginLabel = [[UILabel alloc] initWithFrame:accountLoginButton.bounds];
    accountLoginLabel.text = @"登录";
    accountLoginLabel.textColor = [UIColor whiteColor];
    accountLoginLabel.textAlignment = NSTextAlignmentCenter;
    [accountLoginButton addSubview:accountLoginLabel];
    
    [accountLoginButton addTarget:self action:@selector(accountLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:accountLoginButton];
    
    UIButton *forgetPassPortButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 145, 100, 20)];
    [forgetPassPortButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPassPortButton setTitleColor:[UIColor colorWithRed:52/255.0 green:186/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
    forgetPassPortButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:forgetPassPortButton];
    
    
    //创建子视图
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0+kScreenWidth, 0,kScreenWidth, 44)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:phoneView];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
    phoneLabel.text = @"手机号";
    phoneLabel.textColor = [UIColor darkGrayColor];
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [phoneView addSubview:phoneLabel];
    
    _phoneTextF = [[UITextField alloc] initWithFrame:CGRectMake(65, 0, kScreenWidth - 50, 44)];
    _phoneTextF.placeholder = @"请输入手机号码";
    _phoneTextF.font = [UIFont systemFontOfSize:15];
    //设置代理
    _phoneTextF.delegate = self;
    [phoneView addSubview:_phoneTextF];
    
    _sendMsgButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-110, 12, 100, 20)];
    [_sendMsgButton setBackgroundImage:[UIImage imageNamed:@"unyanzhengma.png"] forState:UIControlStateNormal];
    [_sendMsgButton setBackgroundImage:[UIImage imageNamed:@"yanzhengma"] forState:UIControlStateSelected];
    [_sendMsgButton addTarget:self action:@selector(sendMsgAction:) forControlEvents:UIControlEventTouchUpInside];
    [phoneView addSubview:_sendMsgButton];
    
    
    
    UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(0+kScreenWidth, 45,kScreenWidth, 44)];
    msgView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:msgView];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
    msgLabel.text = @"验证码";
    msgLabel.textColor = [UIColor darkGrayColor];
    msgLabel.font = [UIFont systemFontOfSize:15];
    [msgView addSubview:msgLabel];
    
    _msgTextF = [[UITextField alloc] initWithFrame:CGRectMake(65, 0, kScreenWidth - 50, 44)];
    _msgTextF.placeholder = @"请输入手机短信中的验证码";
    _msgTextF.font = [UIFont systemFontOfSize:15];
    _msgTextF.secureTextEntry = YES;
    [msgView addSubview:_msgTextF];
    
    
    UIButton *PhoneLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(20+kScreenWidth, 100, kScreenWidth - 40, 35)];
    [PhoneLoginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    
    UILabel *PhoneLoginLabel = [[UILabel alloc] initWithFrame:PhoneLoginButton.bounds];
    PhoneLoginLabel.text = @"登录";
    PhoneLoginLabel.textColor = [UIColor whiteColor];
    PhoneLoginLabel.textAlignment = NSTextAlignmentCenter;
    [PhoneLoginButton addSubview:PhoneLoginLabel];
    
    [PhoneLoginButton addTarget:self action:@selector(phoneLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:PhoneLoginButton];
    
    
    //设置分页效果
    _scrollView.pagingEnabled = YES;
    //隐藏水平滑动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //不开启滑动
    _scrollView.scrollEnabled = NO;
}

#pragma mark - UITextFiled 代理
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField != nil) {
        _sendMsgButton.selected = YES;
    }else{
        _sendMsgButton.selected = NO;
    }
}


//注册
- (void)registerAction{
    
    NSLog(@"注册");
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)loginByAccount:(UIButton *)button{
    
    NSLog(@"点击账号登陆");
    _accountTextF.text = nil;
    _passwordTextF.text = nil;
    [UIView animateWithDuration:.5 animations:^{
        _selectedView.transform = CGAffineTransformIdentity;
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
}


- (void)loginByPhone:(UIButton *)button{
    
    NSLog(@"点击手机号登录");
    _phoneTextF.text = nil;
    _msgTextF.text = nil;
    
    [UIView animateWithDuration:.5 animations:^{
        _selectedView.transform = CGAffineTransformMakeTranslation(kScreenWidth/2, 0);
        _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    }];
    
}

//改变密码输入方式
- (void)canSeeAction:(UIButton *)button{
    NSLog(@"改变密码输入方式");

    _passwordTextF.secureTextEntry = !_passwordTextF.secureTextEntry;
    if (_passwordTextF.secureTextEntry == NO) {
        [_canSeeButton setBackgroundImage:[UIImage imageNamed:@"yeye.png"] forState:UIControlStateNormal];
    }else{
        [_canSeeButton setBackgroundImage:[UIImage imageNamed:@"neye.png"] forState:UIControlStateNormal];
    }
    
    _passwordTextF.text = _passwordTextF.text;
}

//发送验证码
- (void)sendMsgAction:(UIButton *)button{
    
    NSLog(@"发送验证码");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_phoneTextF.text forKey:@"mobile"];
    [MyNetWorkQuery requestData:@"http://www.juntu.com/index.php?m=member&c=index&a=public_message" HTTPMethod:@"GET" params:params completionHandle:^(id result) {
        NSLog(@"%@",result);
        NSString *msg = [result objectForKey:@"msg"];
        //显示提示
        dispatch_async(dispatch_get_main_queue(), ^{
            [self alertShow:msg];
        });
    } errorHandle:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"开始滑动");
    if (_scrollView.contentOffset.x == kScreenWidth) {
        [UIView animateWithDuration:.5 animations:^{
            _selectedView.transform = CGAffineTransformMakeTranslation(kScreenWidth/2, 0);
        }];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            _selectedView.transform = CGAffineTransformIdentity;
        }];
    }

}


- (void)accountLoginAction:(UIButton *)button{
    
    NSLog( @"账号登录");
    NSString *urlString = @"http://www.juntu.com/index.php?m=app&c=member&a=login";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_accountTextF.text forKey:@"username"];
    [params setValue:_passwordTextF.text forKey:@"password"];
    [self requestData:urlString Params:params];
}

- (void)phoneLoginAction:(UIButton *)button{
    
    NSLog( @"手机登录");
    NSString *urlString = @"http://www.juntu.com/index.php?m=member&c=index&a=public_f_verification";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_phoneTextF.text forKey:@"mobile"];
    [params setValue:_msgTextF.text forKey:@"code"];
    [self requestData:urlString Params:params];
}

//读取数据
-(void)requestData:(NSString *)urlString Params:(NSMutableDictionary *)params{
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"POST" params:params completionHandle:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *loginListDic = [result objectForKey:@"loginList"];
        NSString *status = [loginListDic objectForKey:@"status"];
        
        //读取信息
        NSDictionary *dic = [loginListDic objectForKey:@"infoArray"];
        UserModel *model = [[UserModel alloc] initContentWithDic:dic];

        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *info = [loginListDic objectForKey:@"info"];
            [self alertShow:info];
            if ([status isEqualToString:@"Y"]) {
                //存入本地
                [[NSUserDefaults standardUserDefaults] setObject:_msgTextF.text forKey:kPassword];
                [[NSUserDefaults standardUserDefaults] setObject:model.userid forKey:kUserID];
                [[NSUserDefaults standardUserDefaults] setObject:model.username forKey:kUserName];
                [[NSUserDefaults standardUserDefaults] setObject:model.nickname forKey:kNickName];
                [[NSUserDefaults standardUserDefaults] setObject:model.mobile forKey:kCellNumber];
                [[NSUserDefaults standardUserDefaults] setObject:model.email forKey:kMail];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if (_block) {
                    _block(model);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
    } errorHandle:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


-(void)alertShow:(NSString *)title{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


@end
