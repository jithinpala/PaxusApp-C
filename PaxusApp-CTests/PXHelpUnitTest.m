//
//  PXHelpUnitTest.m
//  PaxusApp-CTests
//
//  Created by Jithin on 15/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+StringExtension.h"
#import "PXReachability.h"
#import "NetworkingAPI.h"

@interface PXHelpUnitTest : XCTestCase

@end

@implementation PXHelpUnitTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLocalizedString {
    NSString *localizedString = [NSString localizedString:@"alert.yes"];
    XCTAssertEqualObjects(localizedString,@"YES" ,@"The localized string did not match the expected string");
}

- (void)testRechabilityStatus {
    BOOL networkStatus = [[PXReachability sharedManager] checkNetworkIsAvailable];
    XCTAssertTrue(networkStatus,@"Network is connected, return status as false");
}

- (void)testBaseUrlString {
    NSString *baseURL = [[NetworkingAPI sharedManager] apiBaseUrl];
    XCTAssertEqualObjects(baseURL,@"http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors" ,@"NetworkingAPI not returning the expected URL");
    XCTAssertTrue([baseURL isKindOfClass:[NSString class]],@"Expecting object type as NSString");
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
