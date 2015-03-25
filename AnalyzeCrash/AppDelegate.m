//
//  AppDelegate.m
//  AnalyzeCrash
//
//  Created by pennyli on 3/25/15.
//  Copyright (c) 2015 pennyli. All rights reserved.
//

#import "AppDelegate.h"

@interface DropWindow : NSWindow
@end

@implementation DropWindow

@end

@interface AppDelegate () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet DropWindow *window;

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.dataSource = [NSMutableArray arrayWithObjects: @"1", @"2", nil];
     [self.window registerForDraggedTypes: [NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
    [self.tableView reloadData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
{
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row NS_AVAILABLE_MAC(10_7);
{
    static NSString *identifier = @"cell";
    NSTableCellView *cell = [tableView makeViewWithIdentifier: identifier owner: nil];
    if (cell == nil) {
        cell = [[NSTableCellView alloc] initWithFrame: NSZeroRect];
        cell.identifier = identifier;
    }
    cell.textField.stringValue = self.dataSource[row];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 20;
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;
{
    
    if (row < self.dataSource.count) {
        return NSDragOperationNone;
    }
    
    NSLog(@"%ld", row);
    
    return NSDragOperationCopy;
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;
{ 
    NSLog(@"%ld", dropOperation);
    return YES;
}
@end
