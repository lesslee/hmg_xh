//
//  KSDatePicker1.m
//  hmg
//
//  Created by hongxianyu on 2016/12/20.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "KSDatePicker1.h"

@implementation KSDatePicker1

{
    UIDatePicker*_datePicker1;
    UILabel     *_headerView;
    UIButton    *_cancelBtn;
    UIButton    *_commitBtn;
    UIView      *_horizonLine;
    UIView      *_verticalLine;
    
    UIButton    *_maskView;
    }
- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    {
    _maskView = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    {
    _appearance = [KSDatePickerAppearance new];
    }
    
    {
    _datePicker1 = [[UIDatePicker alloc] init];
    [self addSubview:_datePicker1];
    }
    
    {
    _headerView = [[UILabel alloc] init];
    [self addSubview:_headerView];
    }
    
    {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.tag = KSDatePickerButtonCancel;
    [self addSubview:_cancelBtn];
    [_cancelBtn addTarget:self action:@selector(footViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.tag = KSDatePickerButtonCommit;
    [self addSubview:_commitBtn];
    [_commitBtn addTarget:self action:@selector(footViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
    _horizonLine = [[UIView alloc] init];
    [self addSubview:_horizonLine];
    
    _verticalLine = [[UIView alloc] init];
    [self addSubview:_verticalLine];
    }
    
    [self reloadAppearance];
    
}
- (void)reloadAppearance
{
    {
    _maskView.frame = [UIScreen mainScreen].bounds;
    _maskView.backgroundColor = _appearance.maskBackgroundColor;
    }
    
    {
    self.backgroundColor = _appearance.datePickerBackgroundColor;
    if (_appearance.radius > 0) {
        self.layer.cornerRadius = _appearance.radius;
        self.layer.masksToBounds = YES;
    }
    }
    
    {
    _datePicker1.datePickerMode = _appearance.datePickerMode;
    _datePicker1.minimumDate = _appearance.minimumDate;
    _datePicker1.maximumDate = _appearance.maximumDate;
    _datePicker1.date = _appearance.currentDate;
    }
    
    {
    _headerView.text = _appearance.headerText;
    _headerView.font = _appearance.headerTextFont;
    _headerView.textColor = _appearance.headerTextColor;
    _headerView.textAlignment = _appearance.headerTextAlignment;
    _headerView.backgroundColor = _appearance.headerBackgroundColor;
    }
    
    {
    _cancelBtn.titleLabel.font = _appearance.cancelBtnFont;
    [_cancelBtn setBackgroundColor:_appearance.cancelBtnBackgroundColor];
    [_cancelBtn setTitle:_appearance.cancelBtnTitle forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:_appearance.cancelBtnTitleColor forState:UIControlStateNormal];
    }
    
    {
    _commitBtn.titleLabel.font = _appearance.commitBtnFont;
    [_commitBtn setBackgroundColor:_appearance.commitBtnBackgroundColor];
    [_commitBtn setTitle:_appearance.commitBtnTitle forState:UIControlStateNormal];
    [_commitBtn setTitleColor:_appearance.commitBtnTitleColor forState:UIControlStateNormal];
    
    }
    
    {
    _horizonLine.backgroundColor = _appearance.lineColor;
    
    _verticalLine.backgroundColor = _appearance.lineColor;
    }
}

- (void)layoutSubviews
{
    CGFloat supWidth = self.frame.size.width;
    CGFloat supHeight = self.frame.size.height;
    
    {
    _datePicker1.frame = CGRectMake(0, _appearance.headerHeight, supWidth, supHeight - _appearance.headerHeight - _appearance.buttonHeight);
    }
    
    {
    _headerView.frame = CGRectMake(0, 0, supWidth, _appearance.headerHeight);
    }
    
    {
    _cancelBtn.frame = CGRectMake(0 * supWidth / 2 ,supHeight - _appearance.buttonHeight , supWidth / 2, _appearance.buttonHeight);
    
    _commitBtn.frame = CGRectMake(1 * supWidth / 2, supHeight - _appearance.buttonHeight, supWidth / 2, _appearance.buttonHeight);
    }
    
    {
    _horizonLine.frame = CGRectMake(0, supHeight - _appearance.buttonHeight, supWidth, _appearance.lineWidth);
    
    _verticalLine.frame = CGRectMake(supWidth / 2., supHeight - _appearance.buttonHeight, _appearance.lineWidth, _appearance.buttonHeight);
    }
}

- (void)footViewButtonClick:(UIButton*)button
{
    if (_appearance.resultCallBack1) {
        _appearance.resultCallBack1(self,_datePicker1.date,button.tag);
    }
    
    [self hidden];
    
}


- (void)show
{
    [self reloadAppearance];
    
    [self animationWithView:self duration:0.3];
    _maskView.alpha= 0;
    [UIView animateWithDuration:0.25 animations:^{
        _maskView.alpha = 0.5;
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
}
- (void)hidden
{   [_maskView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
