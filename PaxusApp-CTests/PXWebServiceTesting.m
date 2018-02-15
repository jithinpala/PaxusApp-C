//
//  PXWebServiceTesting.m
//  PaxusApp-CTests
//
//  Created by Jithin on 15/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebserviceServerManager.h"
#import "NetworkingAPI.h"
#import "NSTEasyJSON.h"
#import "ActorsModel.h"
#import "ActorsListViewController.h"
#import "PXAlertController.h"
#import "NSString+StringExtension.h"

@interface PXWebServiceTesting : XCTestCase
@property (nonatomic, strong) ActorsListViewController *actorViewController;
@end

@implementation PXWebServiceTesting

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _actorViewController = [[ActorsListViewController alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _actorViewController = nil;
    
}

- (void) testWebserviceFetchCall {
    
    NSString *baseURL = [[NetworkingAPI sharedManager] apiBaseUrl];
    NSString *description = [NSString stringWithFormat:@"GET %@", baseURL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    WebserviceServerManager *serverManager = [WebserviceServerManager sharedManager];
    [serverManager sendRequestToServer:baseURL parameters:nil apiRequestType:@"GET" success:^(NSTEasyJSON *result) {
        NSArray *resultArray = result[@"actors"].array;
        XCTAssertEqual(resultArray.count, 6,@"Array count is not matching with the expected count");
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssertNotNil(error, "Error should not be nil");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (void) testFetchedDataWithModel {
    NSString *baseURL = [[NetworkingAPI sharedManager] apiBaseUrl];
    NSString *description = [NSString stringWithFormat:@"GET %@", baseURL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    WebserviceServerManager *serverManager = [WebserviceServerManager sharedManager];
    [serverManager sendRequestToServer:baseURL parameters:nil apiRequestType:@"GET" success:^(NSTEasyJSON *result) {
        NSArray *resultArray = result[@"actors"].array;
        XCTAssertEqual(resultArray.count, 6,@"Array count is not matching with the expected count");
        [[ActorsModel sharedManager] addActorDetailsToModel:resultArray];
        XCTAssertEqual([[ActorsModel sharedManager] actorsArray].count, 6,@"Model array count is not matching with the expected count");
        [expectation fulfill];
        NSArray *singleActor = [[[ActorsModel sharedManager] actorsArray] objectAtIndex:0];
        XCTAssertEqual(singleActor.count, 8,@"Model array count is not matching with the expected count");
        
    } failure:^(NSError *error) {
        XCTAssertNotNil(error, "Error should not be nil");
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}
-(void)testAlertViewController {
    UIViewController    *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [PXAlertController showSimpleAlertWithMessage:@"Alert.webservice.failure" inController:rootViewController];
    XCTAssertTrue([rootViewController.presentedViewController isKindOfClass:[UIAlertController class]],@"Expecting presented controller is UIAlertController");    
    XCTAssertEqual(rootViewController.presentedViewController.title,[NSString localizedString:@"Product.Display.Name"]);
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
