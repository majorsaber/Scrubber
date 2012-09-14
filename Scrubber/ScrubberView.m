//
//  ScrubberView.m
//  Scrubber
//
//  Created by Sunny Purewal on 09/14/2012
//  Copyright 2012 Sunny Purewal. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without
// limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
// AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
// OR OTHER DEALINGS IN THE SOFTWARE.

#import "ScrubberView.h"

@interface ScrubberView()

-(void)scrubberValueChanged:(UISlider *)slider;
-(void)scrubberDidEndScrubbing:(UISlider *)slider;
-(void)scrubberDidBeginScrubbing:(UISlider *)slider;

@end

@implementation ScrubberView
{
    int _numberOfAnchorPoints;
    float _anchorInterval;
    NSArray *_anchorPoints;
//    UISlider *slider;
}

@synthesize numberOfAnchorPoints=_numberOfAnchorPoints;
@synthesize delegate;

-(void)setNumberOfAnchorPoints:(int)numberOfAnchorPoints
{
    _numberOfAnchorPoints = numberOfAnchorPoints;
    _anchorInterval = 1.0 / (_numberOfAnchorPoints-1);
    
    for (UIView *view in self.subviews) {
        if (view.tag == ANCHOR) {
            [view removeFromSuperview];
        }
    }
    
    CGRect frame = self.frame;
    int anchorDistance = frame.size.width / (_numberOfAnchorPoints - 1);
    for (int i = 0; i < _numberOfAnchorPoints; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anchor.png"]];
        [imgView setTag:ANCHOR];
        [imgView setFrame:CGRectMake((anchorDistance * i) - ((kAnchorImageSize/(_numberOfAnchorPoints-1))*i), 0, kAnchorImageSize, kAnchorImageSize)];
        //TODO:                                             ^^^^^^^^^^^ this part needs to be fixed, it's just an offset inversely proportional to number of anchor points, don't know the exact relation yet but this works alright
        [self addSubview:imgView];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfAnchorPoints = 3;
        _anchorInterval = 1.0 / _numberOfAnchorPoints;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _numberOfAnchorPoints = 3;
        _anchorInterval = 1.0 / _numberOfAnchorPoints;
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        _numberOfAnchorPoints = 3;
        _anchorInterval = 1.0 / _numberOfAnchorPoints;
    }
    
    return self;
}

-(void)awakeFromNib
{
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 23)];
    [self addSubview:slider];
    [slider addTarget:self action:@selector(scrubberValueChanged:) forControlEvents:UIControlEventValueChanged];
    [slider addTarget:self action:@selector(scrubberDidEndScrubbing:) forControlEvents:UIControlEventTouchUpInside];
    [slider addTarget:self action:@selector(scrubberDidEndScrubbing:) forControlEvents:UIControlEventTouchUpOutside];
    [slider addTarget:self action:@selector(scrubberDidBeginScrubbing:) forControlEvents:UIControlEventTouchDown];
}

-(void)scrubberValueChanged:(UISlider *)slider
{
    if ([delegate respondsToSelector:@selector(scrubber:didScrubToValue:)]) {
        [delegate scrubber:self didScrubToValue:slider.value];
    }
}

-(void)scrubberDidEndScrubbing:(UISlider *)slider
{
    float value = slider.value;
    
    int minIndex = _numberOfAnchorPoints + 2;
    float minDistance = CGFLOAT_MAX;
    float distance;
    
    for (int i = 0; i < _numberOfAnchorPoints + 1; i++) {
        distance = fabs(value - (_anchorInterval*i));
        if (distance < minDistance) {
            minIndex = i;
            minDistance = distance;
        }
    }
    
    if ([delegate respondsToSelector:@selector(scrubber:willSelectIndex:)]) {
        [delegate scrubber:self willSelectIndex:minIndex];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [slider setValue:(_anchorInterval*minIndex)];
    } completion:^(BOOL finished) {
        if ([delegate respondsToSelector:@selector(scrubber:didSelectIndex:)]) {
            [delegate scrubber:self didSelectIndex:minIndex];
        }
    }];
}

-(void)scrubberDidBeginScrubbing:(UISlider *)slider
{
    if ([delegate respondsToSelector:@selector(scrubberDidBeginScrubbing:)]) {
        [delegate scrubberDidBeginScrubbing:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
