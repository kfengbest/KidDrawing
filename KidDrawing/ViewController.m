//
//  ViewController.m
//  KidDrawing
//
//  Created by Kaven Feng on 1/21/14.
//  Copyright (c) 2014 Kaven Feng. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DetailsViewController.h"

@interface ViewController ()
{
    NSMutableArray* fileThumbnails;
    ADBannerView *_bannerView;

}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Init from plist
    NSString* path = [[NSBundle mainBundle] pathForResource:@"FileLists" ofType:@"plist"];
    NSDictionary* dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    fileThumbnails = [dic objectForKey:@"Thumbnails"];

    // Init banner view
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        _bannerView = [[ADBannerView alloc] init];
    }
    _bannerView.delegate = self;
    [self.view addSubview:_bannerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [fileThumbnails count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewCell *myCell = [collectionView
                             dequeueReusableCellWithReuseIdentifier:@"PhotoCell"
                             forIndexPath:indexPath];
    
    NSString* path = fileThumbnails[indexPath.row];
    NSString* name = [NSString stringWithFormat:@"%@0.png", path];
    
    UIImage *img = [UIImage imageNamed:name];
    
    myCell.imageView.image = img;
    myCell.imageName.text = fileThumbnails[indexPath.row];
    
    return myCell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailsSegue"]) {
    
        NSArray* selectedItems = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath* path0 = selectedItems[0];
    
        DetailsViewController* detailed = (DetailsViewController*)segue.destinationViewController;
        detailed.name = fileThumbnails[path0.row];
    }
}

- (void)layoutAnimated:(BOOL)animated
{
    CGRect contentFrame = self.view.bounds;
    
    // all we need to do is ask the banner for a size that fits into the layout area we are using
    CGSize sizeForBanner = [_bannerView sizeThatFits:contentFrame.size];
    
    // compute the ad banner frame
    CGRect bannerFrame = _bannerView.frame;
    if (_bannerView.bannerLoaded) {
        
        // bring the ad into view
        contentFrame.size.height -= sizeForBanner.height;   // shrink down content frame to fit the banner below it
        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.size.height = sizeForBanner.height;
        bannerFrame.size.width = sizeForBanner.width;
        
//        // if the ad is available and loaded, shrink down the content frame to fit the banner below it,
//        // we do this by modifying the vertical bottom constraint constant to equal the banner's height
//        //
//        NSLayoutConstraint *verticalBottomConstraint = self.bottomConstraint;
//        verticalBottomConstraint.constant = sizeForBanner.height;
//        [self.view layoutSubviews];
        
    } else {
        // hide the banner off screen further off the bottom
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
//        _contentView.frame = contentFrame;
//        [_contentView layoutIfNeeded];
        _bannerView.frame = bannerFrame;
    }];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"didFailToReceiveAdWithError %@", error);
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
}

- (void)viewDidLayoutSubviews
{
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}

@end
