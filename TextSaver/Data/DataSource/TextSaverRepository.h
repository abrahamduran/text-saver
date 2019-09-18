//
//  TextSaverRepository.h
//  TextSaver
//
//  Created by Abraham Isaac Durán on 9/17/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextSaverDataSource.h"

@interface TextSaverRepository : NSObject <TextSaverDataSource>

- (instancetype) initWithDataSource:(id<TextSaverDataSource>)dataSource;

@end
