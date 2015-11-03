//
//  MyInfoViewController.m
//  我的骏途
//
//  Created by 俞烨梁 on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoCell.h"
#import "UserModel.h"
#import "MyNetWorkQuery.h"

@interface MyInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    MyInfoCell *_cell;
    UIImage *_image;
    UIImageView *_imageView;
    NSString *_userName;
    NSString *_nickName;
    NSString *_cellNumber;
    NSString *_mail;
    NSString *_userid;
}
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    //设置头像
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kUserImage];
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {
        _image = [UIImage imageNamed:@"200.jpg"];

    }else{
        _image = image;
    }
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserID];
    _userid = userId;
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    _userName = userName;
    NSString *nickName = [[NSUserDefaults standardUserDefaults] objectForKey:kNickName];
    _nickName = nickName;
    NSString *cellNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kCellNumber];
    _cellNumber = cellNumber;
    NSString *mail = [[NSUserDefaults standardUserDefaults] objectForKey:kMail];
    _mail = mail;
    //设置头像
//    NSString *imageString = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=member&a=GetAvatar&userid=%@&size=180",_userid];
//    [MyNetWorkQuery requestData:imageString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
//        NSString *imageUrl = result[@"url"];
//        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"200.jpg"]];
//        _image = _imageView.image;
//    } errorHandle:^(NSError *error) {
//        NSLog(@"error");
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//单元格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self getUserInfo];
    
    if (indexPath.row == 0) {
        _cell = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
        _cell.userImageView.image = _image;
        return _cell;
    }else if (indexPath.row == 1){
        _cell = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
        _cell.userNameLabel.text = _userName;
        return _cell;
    }else if (indexPath.row == 2){
        _cell = [tableView dequeueReusableCellWithIdentifier:@"cell03"];
        
        _cell.nickNameTextView.text = _nickName;
        
        [_cell setNickNameBlock:^(NSString *str){
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:kNickName];
            //重新赋值
            _nickName = str;
        }];
        
        return _cell;
    }else if (indexPath.row == 3){
        _cell = [tableView dequeueReusableCellWithIdentifier:@"cell04"];
        
        _cell.cellNumberTextView.text = _cellNumber;
        [_cell setCellNumberBlock:^(NSString *str){
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:kCellNumber];
            //重新赋值
            _cellNumber = str;
        }];
        
        return _cell;
    }else{
        _cell = [tableView dequeueReusableCellWithIdentifier:@"cell05"];
        
        _cell.mailTextView.text = _mail;
        [_cell setMailBlock:^(NSString *str){
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:kMail];
            //重新赋值
            _mail = str;
        }];
        
        return _cell;
    }
    
    
    
}


//单元格高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 100;
    }else{
        return 50;
    }
    
}

//头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self choosePhoto];
    }
    
}

- (void)choosePhoto{
    //创建actionSheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选取", nil];
    
    [actionSheet showInView:self.view];
}

//actionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerControllerSourceType sourceType;
    //拍照
    if (buttonIndex == 0)
    {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"摄像头无法使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertView show];
            
            return;
        }
        
    }else if (buttonIndex == 1){  //相册
        
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }else{
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //返回
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //取出照片
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [_tableView reloadData];
    
    
}

- (IBAction)saveInfoButton:(UIButton *)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"是否修改信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSData *data = UIImageJPEGRepresentation(_image, 1);
        //存图片
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserImage];
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        [param setObject:data forKey:@"url"];
//        [MyNetWorkQuery requestData:@"http://www.juntu.com/index.php?m=app&c=member&a=uploadavatar" HTTPMethod:@"POST" params:nil completionHandle:^(id result) {
//            NSLog(@"%@",result);
//        } errorHandle:^(NSError *error) {
//            NSLog(@"error");
//        }];
        
        //网络数据修改
        NSString *urlString = @"http://www.juntu.com/index.php?m=app&c=member&a=update_info";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_userid forKey:@"userid"];
        [params setObject:_nickName forKey:@"nickname"];
        [params setObject:_cellNumber forKey:@"mobile"];
        [params setObject:_mail forKey:@"email"];

        [MyNetWorkQuery requestData:urlString HTTPMethod:@"POST" params:params completionHandle:^(id result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                [self.navigationController popViewControllerAnimated:YES];
            });
        } errorHandle:^(NSError *error) {
            NSLog(@"error");
        }];
    }
}
@end
