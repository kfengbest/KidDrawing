#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
	SketchPadToolTypePaint = 0,
	SketchPadToolTypeAirBrush
} SketchPadToolType;

@interface DAScratchPadView : UIControl

@property (assign) SketchPadToolType toolType;
@property (strong,nonatomic) UIColor* drawColor;
@property (assign) CGFloat drawWidth;
@property (assign) CGFloat drawOpacity;
@property (assign) CGFloat airBrushFlow;

- (void) clearToColor:(UIColor*)color;

- (UIImage*) getSketch;
- (void) setSketch:(UIImage*)sketch;

@end
