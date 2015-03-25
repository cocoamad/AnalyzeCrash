//
//  DragWindow.h
//  AnalyzeCrash
//
//  Created by pennyli on 15/3/25.
//  Copyright (c) 2015年 pennyli. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DragFileDelegate <NSObject>

- (void)dragFiles:(NSArray *)files;

@end

@interface DragWindow : NSWindow
@property (weak) id <DragFileDelegate> dragDelegate;
@end
