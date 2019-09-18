//
//  TextSaverRepository.m
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/17/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import "TextSaverRepository.h"

@interface TextSaverRepository ()

@property (nonatomic, strong) id<TextSaverDataSource> dataSource;

@end

@implementation TextSaverRepository

@synthesize dataSource;

- (instancetype)initWithDataSource:(id<TextSaverDataSource>)dataSource {
    if (self = [super init]) {
        self.dataSource = dataSource;
    }
    return self;
}

- (NSArray<NSString *> *)getSavedTexts {
    return [dataSource getSavedTexts];
}

- (void)addText:(NSString *)text {
    [dataSource addText:text];
}

- (void)removeTextAtIndex:(NSInteger)index {
    [dataSource removeTextAtIndex:index];
}

- (void)persistData {
    [dataSource persistData];
}

@end
