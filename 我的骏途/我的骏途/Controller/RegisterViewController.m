//
//  RegisterViewController.m
//  骏途旅游
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UITextField *_phoneNumTextF;
    UITextField *_passwordTextF;
    UITextField *_passworkAgainTextF;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免费注册";
    [self _createView];
    // Do any additional setup after loading the view.
}

- (void)_createView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10 + 133 + 64, kScreenWidth - 40, 35)];
    registerButton.backgroundColor  =[UIColor clearColor];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:registerButton.bounds];
    registerLabel.text = @"提交注册";
    registerLabel.textColor = [UIColor whiteColor];
    registerLabel.font = [UIFont systemFontOfSize:15];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    [registerButton addSubview:registerLabel];
    
    [registerButton addTarget:self action:@selector(finishRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        _phoneNumTextF = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth, cell.bounds.size.height)];
        _phoneNumTextF.placeholder = @"填写手机号码";
        _phoneNumTextF.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:_phoneNumTextF];
    }else if (indexPath.row == 1) {
        _passwordTextF = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth, cell.bounds.size.height)];
        _passwordTextF.placeholder = @"填写6~12位密码";
        _passwordTextF.secureTextEntry = YES;
        _passwordTextF.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:_passwordTextF];

    }else if (indexPath.row == 2) {
        _passworkAgainTextF = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth, cell.bounds.size.height)];
        _passworkAgainTextF.placeholder = @"再次输入密码";
        _passworkAgainTextF.secureTextEntry = YES;
        _passworkAgainTextF.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:_passworkAgainTextF];
    }
    
    return cell;
}




- (void)finishRegister:(UIButton *)button{
    
    NSLog(@"提交注册");
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
