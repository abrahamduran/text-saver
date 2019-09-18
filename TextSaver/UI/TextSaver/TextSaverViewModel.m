//
//  TextSaverViewModel.m
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/17/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import "TextSaverViewModel.h"
#import "LocalDataSource.h"
#import "UserDefaultsDataSource.h"
#import "TextSaverRepository.h"
#define MAX_LENGTH 140
#define REGEX_PATTERN @"[<>/:&+%;\"]|\\.\\w{2,4}"

@interface TextSaverViewModel()

@property (nonatomic, strong) TextSaverRepository *repository;
@property (nonatomic, readonly) NSRegularExpression *regex;

@end

@implementation TextSaverViewModel
@synthesize repository;
@synthesize regex;

- (instancetype)init {
    if (self = [super init]) {
        id dataSource = [[LocalDataSource alloc] init];
        self.repository = [[TextSaverRepository alloc] initWithDataSource:dataSource];
        [[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(persistTextsLocally)
         name:@"applicationDidEnterBackground"
         object:nil];
        regex = [NSRegularExpression regularExpressionWithPattern:REGEX_PATTERN options:NSRegularExpressionCaseInsensitive error:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray<NSString *> *)getSavedTexts {
    return [repository getSavedTexts];
}

- (NSString *)sanitizeText:(NSString *)text {
    NSString *result = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, text.length) withTemplate:@""];
    return result;
}

- (BOOL)isTextValid:(NSString *)text {
    NSTextCheckingResult *test = [regex firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
    return test == nil && text.length <= MAX_LENGTH;
}

- (void)saveText:(NSString *)text {
    if ([self isTextValid:text])
        [repository addText:text];
}

- (void)removeTextAtIndex:(NSInteger)index {
    [repository removeTextAtIndex:index];
}

- (void)persistTextsLocally {
    [repository persistData];
}

@end
