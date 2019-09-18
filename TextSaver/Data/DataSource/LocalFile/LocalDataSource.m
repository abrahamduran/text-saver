//
//  LocalDataSource.m
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/17/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import "LocalDataSource.h"
#define JSON_FILE @"savedTexts.json"

@interface LocalDataSource ()

@property (nonatomic, strong) NSMutableArray<NSString *> *savedTexts;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation LocalDataSource
@synthesize savedTexts;
@synthesize filePath;

- (instancetype)init {
    if (self = [super init]) {
        NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.filePath = [filePath stringByAppendingPathComponent: JSON_FILE];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
            [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:nil attributes:nil];
        }
        
        self.savedTexts = [NSMutableArray arrayWithArray: [self getSavedTexts]];
    }
    return self;
}

- (NSArray<NSString *> *)getSavedTexts {
    if (savedTexts)
        return savedTexts;
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    if (jsonData == nil)
        return [NSMutableArray arrayWithCapacity: 0];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    if (jsonData == nil)
        return [NSMutableArray arrayWithCapacity: 0];
    
    return jsonArray;
}

- (void)addText:(NSString *)text {
    [savedTexts addObject:text];
}

- (void)removeTextAtIndex:(NSInteger)index {
    [savedTexts removeObjectAtIndex:index];
}

- (void)persistData {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:savedTexts options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[jsonString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:filePath atomically:NO];
}

@end
