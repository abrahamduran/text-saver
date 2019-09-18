//
//  TextSaverViewController.h
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/16/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextSaverViewModel.h"

@interface TextSaverViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) TextSaverViewModel *viewModel;

@end

