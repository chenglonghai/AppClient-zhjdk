//
//  MLBasePageViewController.m
//  MLPageVC
//
//  Created by 玛丽 on 2017/12/11.
//  Copyright © 2017年 玛丽. All rights reserved.
//

#import "MLBasePageViewController.h"
#import "HMSegmentedControl.h"


//#define kScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
//#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface MLBasePageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) HMSegmentedControl *segmented;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, assign) NSInteger currentSelectIndex;

@end

@implementation MLBasePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar  setShadowImage:[UIImage new]];
    self.segmented.sectionTitles = self.sectionTitles;
    [self.pageVC setViewControllers:@[self.VCArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.view addSubview:self.segmented];
    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
}

#pragma mark - UIPageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.VCArray indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    return (UIViewController *)[self.VCArray objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.VCArray indexOfObject:viewController];
    if(index == NSNotFound || index == self.VCArray.count - 1) {
        return nil;
    }
    return (UIViewController *)[self.VCArray objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(nonnull NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.pageVC.viewControllers[0];
    NSUInteger index = [self.VCArray indexOfObject:viewController];
    self.currentSelectIndex = index;
    [self.segmented setSelectedSegmentIndex:index animated:YES];
}

- (void)segmentedControlChangedValue:(UISegmentedControl *)segment {
    long index = segment.selectedSegmentIndex;
    [self navigationDidSelectedControllerIndex:index];
}

- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    if (index == 0) {
        [self.pageVC setViewControllers:@[[self.VCArray objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }
    else {
        [self.pageVC setViewControllers:@[[self.VCArray objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                options:options];
        _pageVC.view.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-44);
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    return _pageVC;
}

- (HMSegmentedControl *)segmented {
    if (!_segmented) {
        _segmented = [[HMSegmentedControl alloc] init];
        _segmented.frame = CGRectMake(0, 0, kScreenWidth, 44);
        _segmented.selectionIndicatorHeight = 2.0f;
        _segmented.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmented.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmented.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
        _currentSelectIndex = 0;
        _segmented.selectedSegmentIndex = _currentSelectIndex;
        _segmented.selectionIndicatorColor = [UIColor  whiteColor];
    
        _segmented.backgroundColor = [UIColor colorddbb99];
        [_segmented addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmented;
}

@end
