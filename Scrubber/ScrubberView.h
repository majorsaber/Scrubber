//
//  ScrubberView.h
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

#define ANCHOR 4
#define kAnchorImageSize 24

#import <UIKit/UIKit.h>

@class ScrubberView;

@protocol ScrubberDelegate <NSObject>

-(void)scrubber:(ScrubberView*)scrubber didSelectIndex:(int)index;
-(void)scrubber:(ScrubberView *)scrubber didScrubToValue:(float)value;
-(void)scrubberDidBeginScrubbing:(ScrubberView*)scrubber;
-(void)scrubber:(ScrubberView *)scrubber willSelectIndex:(int)index;

@end

@interface ScrubberView : UIView

@property (nonatomic) int numberOfAnchorPoints;
@property (nonatomic, weak) IBOutlet id<ScrubberDelegate> delegate;

@end
