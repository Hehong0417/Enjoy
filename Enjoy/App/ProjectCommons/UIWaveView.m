
#import "UIWaveView.h"

@implementation UIWaveView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.A = 0.5;
        self.radian = 0;
        self.φ = 0.5;
        
        [NSTimer scheduledTimerWithTimeInterval:0.06
                                         target:self
                                       selector:@selector(animateWave) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)animateWave{
    
    if (self.A < 1) {
        self.A += 0.1;
    }
    
    if (self.A > 1) {
        self.A -= 0.1;
    }
    
    self.φ += 0.3;
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 颜色
    CGColorRef color = IWColor(163, 231, 128).CGColor;
    CGContextSetLineWidth(ctx, 1.0);
    //CGContextSetStrokeColorWithColor(ctx, color);
    // 设置路径的填充色
    CGContextSetFillColorWithColor(ctx, color);
    
    
    // 创建一个可变的路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, self.startY);
    
    for (int x = 0; x <= kDeviceWidth; x++) {
        //radian = x * M_PI / 180.0f;
        float y = 1 * self.A * sin(x * M_PI / 8.0f + self.φ) + self.startY;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    CGPathAddLineToPoint(path,NULL,kDeviceWidth,rect.size.height);
    CGPathAddLineToPoint(path,NULL,0,rect.size.height);
    CGPathAddLineToPoint(path,NULL,0,self.startY);
    
    CGContextAddPath(ctx, path);
    // 填充路径
    CGContextFillPath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
    
}
@end
