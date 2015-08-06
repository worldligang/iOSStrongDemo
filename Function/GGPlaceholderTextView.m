//
//  GGPlaceholderTextView.m
//  iOSStrongDemo
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGPlaceholderTextView.h"

@implementation GGPlaceholderTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addObserver];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self addObserver];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.text = placeholder;
    self.textColor = [UIColor grayColor];
}

-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminate:) name:UIApplicationWillTerminateNotification object:[UIApplication sharedApplication]];
}

- (void)terminate:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didBeginEditing:(NSNotification *)notification {
    if ([self.text isEqualToString:self.placeholder]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
    }
}

- (void)didEndEditing:(NSNotification *)notification {
    if (self.text.length<1) {
        self.text = self.placeholder;
        self.textColor = [UIColor grayColor];
    }
}

@end
