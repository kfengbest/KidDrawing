//
//  BackgoundViewController.h
//  TestImageGallary
//
//  Created by fengka on 12/2/12.
//  Copyright (c) 2012 fengka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SketchPadView.h"

@interface DetailsViewController : UIViewController<UIScrollViewDelegate>
{
    
    IBOutlet SketchPadView *sketchPad;
}

@property (strong, nonatomic) NSString *name;

@end
