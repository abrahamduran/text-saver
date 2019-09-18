//
//  TextSaverTests.m
//  TextSaverTests
//
//  Created by Abraham Isaac Durán on 9/16/19.
//  Copyright © 2019 Abraham Isaac Durán. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TextSaverViewModel.h"

@interface TextSaverTests : XCTestCase

@property (nonatomic) TextSaverViewModel *viewModel;

@end

@implementation TextSaverTests
@synthesize viewModel;

- (void)setUp {
    viewModel = [[TextSaverViewModel alloc] init];
}

- (void)tearDown {
    viewModel = nil;
}

- (void)testViewModel_TextLargerThan140Chars_shouldBeInvalid {
    // Arrange
    NSString *longText = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et mag";
    
    // Asssert
    XCTAssertFalse([viewModel isTextValid:longText]);
}

- (void)testViewModel_TextShorterThan141Chars_shouldBeValid {
    // Arrange
    NSString *shortText = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et ma";
    
    // Asssert
    XCTAssertTrue([viewModel isTextValid:shortText]);
}

- (void)testViewModel_TextWithHTMLTags_shouldBeInvalid {
    // Arrange
    NSString *htmlText = @"<html> <body> <p>Hello, World</p> </body> </html>";
    
    // Asssert
    XCTAssertFalse([viewModel isTextValid:htmlText]);
}

- (void)testViewModel_TextWithNoHTMLTags_shouldBeValid {
    // Arrange
    NSString *nohtmlText = @"html body pHello, Worldp body html";
    
    // Asssert
    XCTAssertTrue([viewModel isTextValid:nohtmlText]);
}

- (void)testViewModel_SanitizingTextWithHTMLTags_shouldRemoveHTMLChars {
    // Arrange
    NSString *htmlText = @"<html> <body> <p>Hello, World</p> </body> </html>";
    NSString *expected = @"html body pHello, Worldp body html";
    
    // Act
    NSString *result = [viewModel sanitizeText:htmlText];
    
    // Assert
    XCTAssertTrue([result isEqualToString:expected]);
}

- (void)testViewModel_Saving_shouldNotAllowInvalidText {
    // Arrange
    NSString *invalidText = @"<html> <body> <p>Hello, World</p> </body> </html>";
    NSInteger expected = 0;
    
    // Act
    [viewModel saveText:invalidText];
    NSArray *result = [viewModel getSavedTexts];
    
    // Assert
    XCTAssertEqual(result.count, expected);
}

- (void)testViewModel_Saving_shouldAllowValidText {
    // Arrange
    NSString *validText = @"Hello, World";
    NSInteger expected = 1;
    
    // Act
    [viewModel saveText:validText];
    NSArray *result = [viewModel getSavedTexts];
    
    // Assert
    XCTAssertEqual(result.count, expected);
    XCTAssertTrue([[result firstObject] isEqualToString:validText]);
}

- (void)testViewModel_Removing_shouldRemove {
    // Arrange
    NSString *validText = @"Hello, World";
    NSInteger expected = 0;
    
    // Act
    [viewModel saveText:validText];
    [viewModel removeTextAtIndex:0];
    NSArray *result = [viewModel getSavedTexts];
    
    // Assert
    XCTAssertEqual(result.count, expected);
}

@end
