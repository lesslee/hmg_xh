//
//  HeaderCRView.m
//  hmg
//
//  Created by hongxianyu on 2016/12/20.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "HeaderCRView.h"
#import "SDCycleScrollView.h"
@interface HeaderCRView ()

@end

@implementation HeaderCRView
-(instancetype)initWithFrame:(CGRect)frame{
   
    if (self = [super initWithFrame:frame]) {
            //添加图片轮播器
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        NSArray *images = @[@"u-za.jpg",@"denti.jpg",@"phyll.jpg",@"tgm.jpg"];
        NSArray *titles = @[@"婴童洗护",@"口腔护理",@"益智喂养",@"硅胶奶瓶"];
         SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 160) shouldInfiniteLoop:YES imageNamesGroup:images];
        cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"banner_dot_select"];
                cycleScrollView.pageDotImage = [UIImage imageNamed:@"banner_dot_normal"];
                cycleScrollView.titlesGroup = titles;
                cycleScrollView.autoScrollTimeInterval = 3.0;
        [self addSubview:cycleScrollView];
    }
    return self;
}
@end
