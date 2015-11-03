//
//  siftType.m
//  骏途旅游
//
//  Created by mac10 on 15/10/20.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "siftType.h"
#import "RequestJSON.h"
@implementation siftType
{
    NSMutableArray *_selectionArray;
}
-(NSArray *)getData:(NSString *)type{
    _selectionArray = [NSMutableArray array];
    
    if([_type isEqualToString:@"风景"]){
        NSString *topic = @"http://www.juntu.com/index.php?m=app&c=&c=scenic_rec&a=category";
        [self LoadData:topic withKey:@"categoryList"];
        
    }else if ([_type isEqualToString:@"酒店"]){
        
    }else if ([_type isEqualToString:@"景+酒"]){
        NSString *topic = @"http://www.juntu.com/index.php?m=app&c=&c=scenic_rec&a=category";
        [self LoadData:topic withKey:@"categoryList"];
        
    }else{
        //获取数据
        NSString *day =@"http://www.juntu.com/index.php?m=app&c=tours&a=playday";
        NSString *type = @"http://www.juntu.com/index.php?m=app&c=route_rec&a=getAroundOfferednature";
        NSString *topic = @"http://www.juntu.com/index.php?m=app&c=&c=scenic_rec&a=category";
        
        [self LoadData:day withKey:@"playdayList"];
        [self LoadData:topic withKey:@"categoryList"];
        [self LoadData:type withKey:@"list"];
    }
    NSArray *finalArray = [self finallArray];
    
    return finalArray;
}

-(void)LoadData:(NSString *)url withKey:(NSString *)key
{
    /*
     排序
     升序
     http://www.juntu.com/index.php?m=app&c=route_rec&a=tours&tourstype=1&listorder=up
     降序
     http://www.juntu.com/index.php?m=app&c=route_rec&a=tours&tourstype=1&listorder=down
     */
    
    //不可使用异步加载
    NSDictionary *result = [RequestJSON loadDataInternet:url];
    NSArray *array = result [key];
    NSMutableArray *nameArray = [NSMutableArray array];
    for(NSDictionary *dic in array){
        NSString *name = dic[@"name"];
        //将获得的字符串存入数组
        [nameArray addObject:name];
    }
    //将一列的数据加入一个数组
    [_selectionArray addObject:nameArray];
 
}
-(NSArray *)finallArray{
NSArray *title;
if([_type isEqualToString:@"风景"]){//风景
    title = @[@"门票价格" ,@"门票主题" ,@"目的地" ];
    NSArray *array1 = @[@"不限",@"￥0-￥100",@"￥100-￥200",@"￥200以上"];
    NSArray *array3 = @[@"不限",@"西安市",@"铜川市",@"宝鸡市",@"咸阳市",@"渭南市",@"延安市",@"汉中市",@"榆林市",@"安康市"];
    
    [_selectionArray insertObject:array1 atIndex:0];
    [_selectionArray addObject:array3];
}else if ([_type isEqualToString:@"酒店"]){//酒店
    title = @[@"城市" ,@"酒店类型" ,@"星级价格",@"排序" ];
    NSArray *array1 = @[@"不限",@"西安市",@"铜川市",@"宝鸡市",@"咸阳市",@"渭南市",@"延安市",@"汉中市",@"榆林市",@"安康市"];
    NSArray *array2 = @[@"请选择",@"客栈名宿",@"高级连锁",@"快捷酒店",@"度假酒店",@"精品酒店",@"青年旅社"];
    NSArray *array3 = @[@"不限",@"￥150以下",@"￥150-￥300",@"￥200-￥600",@"￥600以上"];
    NSArray *array4 = @[@"生序",@"降序"];
    [_selectionArray addObject:array1];
    [_selectionArray addObject:array2];
    [_selectionArray addObject:array3];
    [_selectionArray addObject:array4];
    
}else if ([_type isEqualToString:@"景+酒"]){//景点加酒店
    title = @[@"价格" ,@"主题" ,@"景点" ];
    NSArray *array1 = @[@"不限",@"￥0-￥100",@"￥100-￥200",@"￥200以上"];
    NSArray *array3 = @[@"呵呵"];
    [_selectionArray insertObject:array1 atIndex:0];
    [_selectionArray addObject:array3];
}else{
    title = @[@"游玩天数" ,@"主题分类" ,@"参团性质" ,@"价格排序" ];
    NSArray *array = @[@"生序",@"降序"];
    [_selectionArray addObject:array];
    
    }
    return _selectionArray;
}
-(NSArray *)gettitle:(NSString *)type{
    NSArray *title;
    if([_type isEqualToString:@"风景"]){//风景
        title = @[@"门票价格" ,@"门票主题" ,@"目的地" ];
    }else if ([_type isEqualToString:@"酒店"]){//酒店
        title = @[@"城市" ,@"酒店类型" ,@"星级价格",@"排序" ];
        
    }else if ([_type isEqualToString:@"景+酒"]){//景点加酒店
        title = @[@"价格" ,@"主题" ,@"景点" ];
    }else{
        title = @[@"游玩天数" ,@"主题分类" ,@"参团性质" ,@"价格排序" ];
        
    }
    return title;
}

@end
