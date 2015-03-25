//
//  AppDelegate.m
//  AnalyzeCrash
//
//  Created by pennyli on 3/25/15.
//  Copyright (c) 2015 pennyli. All rights reserved.
//

#import "AppDelegate.h"
#import "DragWindow.h"

@interface AppDelegate () <NSTableViewDataSource, NSTableViewDelegate, DragFileDelegate>

@property (weak) IBOutlet DragWindow *window;

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSButton *analyzeBtn;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.window.dragDelegate = self;
    self.dataSource = [NSMutableArray array];
    [self.window registerForDraggedTypes: [NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
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

#pragma mark Drag File Delegate
- (void)dragFiles:(NSArray *)files
{
    [self.dataSource addObjectsFromArray: files];
    [self.tableView reloadData];
}

- (IBAction)analyze:(id)sender
{
    NSLog(@"123");
}
@end
