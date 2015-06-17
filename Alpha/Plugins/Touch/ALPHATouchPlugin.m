//
//  ALPHATouchPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 Unified Sense. All rights reserved.
//

#import "ALPHATouchPlugin.h"

#import "FLEXResources.h"
#import "UIApplication+Event.h"

#import "ALPHATouchWindow.h"
#import "ALPHABlockActionItem.h"

@interface ALPHATouchPlugin ()

@property (nonatomic, strong) ALPHATouchWindow *touchWindow;

@end

@implementation ALPHATouchPlugin

- (ALPHATouchWindow *)touchWindow
{
    if (!_touchWindow)
    {
        _touchWindow = [[ALPHATouchWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //_touchWindow.rootViewController = [UIViewController new];
        _touchWindow.userInteractionEnabled = NO;
    }
    
    return _touchWindow;
}

- (void)setShouldDisplayTouches:(BOOL)shouldDisplayTouches
{
    _shouldDisplayTouches = shouldDisplayTouches;
    
    if (!self.touchWindow.isKeyWindow)
    {
        [self.touchWindow makeKeyAndVisible];
    }
    
    self.touchWindow.hidden = !_shouldDisplayTouches;
}

#pragma mark - Initializers

- (id)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.touch"];
    
    if (self)
    {
        ALPHABlockActionItem *touchAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.touch.touches"];
        touchAction.title = @"Touches";
        touchAction.icon = [FLEXResources selectIcon];
        touchAction.actionBlock = ^id(id sender){
            self.shouldDisplayTouches = !self.shouldDisplayTouches;
            
            return nil;
        };

        [self registerAction:touchAction];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterfaceEvent:) name:ALPHAInterfaceEventNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleInterfaceEvent:(NSNotification *)notification
{
    if (self.shouldDisplayTouches && [notification.object isKindOfClass:[UIEvent class]])
    {
        UIEvent* event = notification.object;
        
        if (event.type == UIEventTypeTouches)
        {
            [self.touchWindow displayEvent:event];
        }
    }
}

@end
