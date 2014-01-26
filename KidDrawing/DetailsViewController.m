//
//  BackgoundViewController.m
//  TestImageGallary
//
//  Created by fengka on 12/2/12.
//  Copyright (c) 2012 fengka. All rights reserved.
//

#import "DetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailsViewController ()
{
    UIPageControl* pageControl;
    UIScrollView* sv;
}
@end

@implementation DetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    int num = 4;
    int imageW = 300;
    int imageH = 300;
    
    self.navigationItem.title = self.name;
    // SrollView
    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    sv.contentSize = CGSizeMake(self.view.frame.size.width * num,self.view.frame.size.height);
    [self.view addSubview:sv];
    
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator  = NO;
    [sv setDelegate:self];
    
    for (int i = 0; i < num; i++) {
        UIView* subView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        NSString* name = [NSString stringWithFormat:@"%@%d.png", self.name,i+1];
        UIImage *img = [UIImage imageNamed:name];
  
        int dx = (subView.frame.size.width - imageW) / 2;
        int dy = (subView.frame.size.height - imageH) / 2;
        UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(dx, dy, imageW, imageH)];
        [imgView setImage:img];
        
        [subView addSubview:imgView];
        [sv addSubview:subView];
        
    }
    
    // Page Control
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 20, self.view.frame.size.width, 20)];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:pageControl];
    
    pageControl.numberOfPages = num;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation
                                   duration:duration];

//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        int w = self.view.bounds.size.width;
//        int h = self.view.bounds.size.height;
//        self.view.frame = CGRectMake(0, 0, 568, 300);
//        
//        sv.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        sv.contentSize = CGSizeMake(self.view.frame.size.width * 4,self.view.frame.size.height);
//        
//    }else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
//        int w = self.view.bounds.size.width;
//        int h = self.view.bounds.size.height;
//        self.view.frame = CGRectMake(0, 0, 568, 300);
//        sv.contentSize = CGSizeMake(self.view.frame.size.width * 4,self.view.frame.size.height);
//
//        
//    }else if (toInterfaceOrientation == UIInterfaceOrientationPortrait){
//        self.view.frame = CGRectMake(0, 0, 300, 568);
//        sv.contentSize = CGSizeMake(self.view.frame.size.width * 4,self.view.frame.size.height);
//    }
    
}


@end
