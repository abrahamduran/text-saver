//
//  TextSaverViewController.m
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/16/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import "TextSaverViewController.h"

@interface TextSaverViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readonly) NSArray<NSString *> *texts;

@end

@implementation TextSaverViewController
@synthesize searchBar;
@synthesize tableView;
@synthesize viewModel;

- (NSArray<NSString *> *)texts {
    return [viewModel getSavedTexts];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UISearchBar usage favors only UI
    // Same results could have been achieved using UITextField,
    // however it would have required more work in the UI (e.g. styling the textfield)
    searchBar.delegate = self;
    [searchBar
     setImage:[UIImage imageNamed:@"send"]
     forSearchBarIcon:
     UISearchBarIconSearch
     state: UIControlStateNormal ];
    searchBar.placeholder = @"Type the text you wish to save";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    viewModel = [[TextSaverViewModel alloc] init];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark TableView delegates & datasource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.texts.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text-cell" forIndexPath:indexPath];
    NSInteger index = self.texts.count - indexPath.row - 1;
    cell.textLabel.text = self.texts[index];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction *action, UIView *sourceView, void (^completionHandler)(BOOL)) {
        UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.viewModel removeTextAtIndex:indexPath.row];
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

#pragma mark SearchBar delegates
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newString = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([newString characterAtIndex:newString.length - 1] == '\n')
        newString = [newString substringFromIndex:newString.length - 1];
    
    NSString *sanitized = [viewModel sanitizeText:newString];
    
    if (sanitized.length == newString.length)
        return [viewModel isTextValid:newString];
    else
        [searchBar setText:sanitized];
    
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [viewModel saveText:searchBar.text];
    [searchBar setText:@""];
    [tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}
@end
