//
//  MainCollectionView.h
//  骏途旅游
//
//  Created by 俞烨梁 on 15/10/7.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray *titles;      //标题
@property(nonatomic,strong)NSArray *imageNames;  //未联网时加载的图片名
@property(nonatomic,strong)NSArray *imageData;   //联网时加载的图片数据

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                    imageData:(NSArray *)imageData
                   imageNames:(NSArray *)imageNames;


@end
