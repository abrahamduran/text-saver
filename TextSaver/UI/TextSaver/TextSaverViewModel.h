//
//  TextSaverViewModel.h
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/17/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextSaverViewModel : NSObject

- (NSArray<NSString *> *)getSavedTexts;
- (NSString *)sanitizeText:(NSString *)text;
- (BOOL)isTextValid:(NSString *)text;
- (void)saveText:(NSString *)text;
- (void)removeTextAtIndex:(NSInteger)index;

@end
