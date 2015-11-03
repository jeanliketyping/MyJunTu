//
//  UserModel.h
//  我的骏途
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

//个人信息修改：
//http://www.juntu.com/index.php?m=app&c=member&a=update_info&userid=46161&email=598304953@qq.com&nickname=&mobile=13758246113

//http://www.juntu.com/index.php?m=app&c=member&a=GetAvatar&userid=46163&size=180
//修改照片
//http://www.juntu.com/index.php?m=app&c=member&a=uploadavatar
/*
 {
	"status": 0,
	"msg": "保存成功",
	"url": "\/var\/www\/juntu\/travel2.0\/phpsso_server\/uploadfile\/avatar\/5\/8\/47658\/"
 }
 */
#import "BaseModel.h"

@interface UserModel : BaseModel

@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *mobile;//手机号
@property(nonatomic,copy)NSString *nickname;//用户昵称
@property(nonatomic,copy)NSString *userid;//用户id
@property(nonatomic,copy)NSString *username;//用户名

@end
