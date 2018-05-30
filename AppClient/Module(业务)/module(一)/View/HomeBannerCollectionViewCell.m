//
//  HomeBannerCollectionViewCell.m
//  AppClient
//
//  Created by xinz on 2017/12/28.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "HomeBannerCollectionViewCell.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "LunboModel.h"

#define Width [UIScreen mainScreen].bounds.size.width
@interface HomeBannerCollectionViewCell ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 *  指示label
 */
@property (nonatomic, strong) UILabel *indicateLabel;

/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@end



@implementation HomeBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
//        for (int index = 0; index < 5; index++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
//            [self.imageArray addObject:image];
//        }
        [self setupUI];
    }
    return self;
}

- (void)setLunboArray:(NSMutableArray *)lunboArray
{
    if (_lunboArray != lunboArray) {
        _lunboArray = lunboArray;
    }
    [self.imageArray removeAllObjects];
    for (int i = 0; i < _lunboArray.count; i++) {
        LunboModel *lunboModel = _lunboArray[i];
        NSLog(@"=======%@",lunboModel.picUrl);
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",lunboModel.picUrl]];
        [self.imageArray addObject:[NSString stringWithFormat:@"%@",lunboModel.picUrl]];
    }
    self.pageFlowView.orginPageCount = self.imageArray.count;
    [self.pageFlowView reloadData];
}

- (void)setupUI {
    
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 8, Width, Width * 9 / 16)];
    pageFlowView.backgroundColor = [UIColor coloreeeeee];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24, Width, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    
    //    [self.view addSubview:pageFlowView];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [self addSubview:bottomScrollView];
    
    [bottomScrollView addSubview:pageFlowView];
    
    self.pageFlowView = pageFlowView;
    //添加到主view上
    [self addSubview:self.indicateLabel];
    
}
#pragma mark NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width, Width * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    //在这里下载网络图片
    //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]]] ;
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"TestViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
