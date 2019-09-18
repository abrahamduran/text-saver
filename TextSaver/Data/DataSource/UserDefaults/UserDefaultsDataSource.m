//
//  UserDefaultsDataSource.m
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/17/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import "UserDefaultsDataSource.h"

@interface UserDefaultsDataSource ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSMutableArray *savedTexts;

@end

@implementation UserDefaultsDataSource
@synthesize userDefaults;
@synthesize savedTexts;

- (instancetype)init {
    if (self = [super init]) {
        self.userDefaults = NSUserDefaults.standardUserDefaults;
        self.savedTexts = [NSMutableArray arrayWithArray: [self getSavedTexts]];
    }
    return self;
}

- (NSArray<NSString *> *)getSavedTexts {
    if (savedTexts)
        return [savedTexts copy];
    
    NSData *data = [userDefaults objectForKey:@"saved-texts"];
    if (data) {
        NSArray<NSString *> *objects = [NSKeyedUnarchiver unarchivedObjectOfClass:NSArray.class fromData:data error:nil];
        savedTexts = [NSMutableArray arrayWithArray:objects];
    } else {
        savedTexts = [NSMutableArray arrayWithCapacity: 0];
    }
    
    return [savedTexts copy];
}

- (void)addText:(NSString *)text {
    [savedTexts addObject:text];
}

- (void)removeTextAtIndex:(NSInteger)index {
    [savedTexts removeObjectAtIndex:index];
}

- (void)persistData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:savedTexts requiringSecureCoding:NO error:nil];
    [userDefaults setObject:data forKey:@"saved-texts"];
}

@end
