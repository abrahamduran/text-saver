//
//  TextSaverViewController.m
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/16/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import "TextSaverViewController.h"

@interface TextSaverViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *seachBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TextSaverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_seachBar
     setImage:[UIImage imageNamed:@"send"]
     forSearchBarIcon:
     UISearchBarIconSearch
     state: UIControlStateNormal ];
    _seachBar.placeholder = @"Type the text you wish to save";
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"text-cell" forIndexPath:indexPath];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
        UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            // TODO: delete logic here
            [self deleteAtIndex:indexPath.row];
            completionHandler(YES);
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            completionHandler(NO);
        }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Delete Text" message:@"Are you sure you want to delete {the text}?" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:delete];
        [controller addAction:cancel];
        
        [self presentViewController:controller animated:YES completion:nil];
    }];
    [delete setImage: [UIImage imageNamed:@"trash"]];
    delete.backgroundColor = [UIColor colorNamed:@"dark-red"];

    return [UISwipeActionsConfiguration configurationWithActions:@[delete]];
}

- (void)deleteAtIndex:(NSInteger)index {
    // TODO: delete logic here
}

@end
