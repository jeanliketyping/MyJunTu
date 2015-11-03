//
//  SelectedView.m
//  周边游
//
//  Created by 俞烨梁 on 15/10/22.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//



#import "SelectedView.h"

@implementation SelectedView
{
    UIView *_maskView;
    UITableView *_tableView;
    NSMutableArray *_btnArray;
    SelectedButton *_selectedBtn;
    NSArray *_data;
    NSArray *_titles;
    NSArray *_dataArray;
    NSInteger _tag;
}
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                         data:(NSArray *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMaskView];
        [self createTableView];
        
        _btnArray = [NSMutableArray array];
        _titles = titles;
        _data = data;
        
        [self createBtn];
    }
    return self;
}


- (void)createMaskView{
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.3];
    _maskView.hidden = YES;
    [self addSubview:_maskView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [_maskView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    _tableView.hidden = YES;
    SelectedButton *btn = (SelectedButton *)[self viewWithTag:_tag];
    btn.isSelect = !btn.isSelect;
    _maskView.hidden = YES;
    self.height = 40;
}

- (void)createBtn{
    CGFloat btnWidth = kScreenWidth/_titles.count;
    for (int i = 0; i < _titles.count; i++) {
        
        _selectedBtn = [[SelectedButton alloc]initWithFrame:CGRectMake(i * btnWidth, 0, btnWidth, 40) title:_titles[i]];
        
        _selectedBtn.tag = i + 100;
        
        [_selectedBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnArray addObject:_selectedBtn];
        
        _selectedBtn.backgroundColor = [UIColor whiteColor];
        [self addSubview:_selectedBtn];
        
        
    }
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 0) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.hidden = YES;
    
    [self addSubview:_tableView];
}

- (void)btnAction:(SelectedButton *)btn{
    _tag = btn.tag;
    NSInteger index = btn.tag - 100;
    //设置不同高度
    NSArray *array = _data[index];
    CGFloat height = 44 * array.count;
    if (height < 180) {
        _tableView.height = height;
    }else{
        _tableView.height = 180;
    }
    
    for (int i = 0; i < _titles.count; i++)
    {
        if (index == i ) {
            //选中button状态不变
            continue;
        }else{
            //其余button的isSelect变为NO
            SelectedButton *button = _btnArray[i];
            button.isSelect = NO;
        }
    }
    
    //选中button的isSelect取反
    btn.isSelect = !btn.isSelect;
    
    if (btn.isSelect) {
        _tableView.hidden = NO;
        _maskView.hidden = NO;
        self.height = kScreenHeight;
    }else{
        _tableView.hidden = YES;
        _maskView.hidden = YES;
        self.height = 40;
        
    }
    
    _dataArray = _data[index];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中单元格发送数据 进行筛选
    
}

@end
