//
//  TextSaverDataSource.h
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/17/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TextSaverDataSource <NSObject>

- (NSArray<NSString *> *)getSavedTexts;
- (void)addText:(NSString *)text;
- (void)removeTextAtIndex:(NSInteger)index;

@optional
- (void)persistData;

@end

