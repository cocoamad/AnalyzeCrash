//
//  DragWindow.m
//  AnalyzeCrash
//
//  Created by 鹏 李 on 15/3/25.
//  Copyright (c) 2015年 pennyli. All rights reserved.
//

#import "DragWindow.h"

@implementation DragWindow
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    BOOL dragResult = NSDragOperationNone;
    BOOL isDirectory = YES;
    if ([[pboard types] containsObject: NSFilenamesPboardType]) {
        NSArray *files = [pboard propertyListForType: NSFilenamesPboardType];
        for (NSString *path in files) {
            NSError *error = nil;
            NSString *utiType = [[NSWorkspace sharedWorkspace]
                                 typeOfFile:path error:&error];
            if (![[NSWorkspace sharedWorkspace]
                  type:utiType conformsToType:(id)kUTTypeDirectory]) {
                isDirectory = NO;
            }
        }
        if (!isDirectory) {
            dragResult = NSDragOperationCopy;
        }
    }
    return dragResult;
}

//perform the drag and log the files that are dropped
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject: NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType: NSFilenamesPboardType];
        NSMutableArray *avaliableFiles = [NSMutableArray array];
        for (NSString *path in files) {
            NSError *error = nil;
            NSString *utiType = [[NSWorkspace sharedWorkspace]
                                 typeOfFile:path error:&error];
            if (![[NSWorkspace sharedWorkspace]
                  type:utiType conformsToType:(id)kUTTypeDirectory]) {
                if ([[path pathExtension] isEqualToString: @"crash"] ||[[path pathExtension] isEqualToString: @"ips"]) {
                    [avaliableFiles addObject: path];
                }
                
            }
            
        }
        if([avaliableFiles count] > 0) {
            if (_dragDelegate && [_dragDelegate respondsToSelector: @selector(dragFiles:)]) {
                [_dragDelegate dragFiles: avaliableFiles];
            }
        }
        return [avaliableFiles count] > 0;
    }
    return NO;
}
@end
