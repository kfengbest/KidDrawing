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
    
//    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collectionViewLayout;
//    flow.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    
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

@end
