//
//  AssessmentMVVMTests.swift
//  AssessmentMVVMTests
//
//  Created by Ady on 11/7/18.
//  Copyright © 2018 Ady. All rights reserved.
//

import XCTest
@testable import AssessmentMVVM

class AssessmentMVVMTests: XCTestCase {

    var countryViewModel: CountryViewModel!
    let timeout = 5.0
    
    override func setUp() {
        countryViewModel = CountryViewModel()
    }

    override func tearDown() {
        countryViewModel = nil
    }

    func testAsyncNetworkCall() {
        
        let expected = expectation(description: "async network call test")
        let networkHandler = NetworkHandler.sharedInstance
        networkHandler.fetchDataFromApi { (response, error) in
            if error == nil {
                expected.fulfill()
            } else {
                XCTFail()
            }
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testgetDataFromApi() {
        
        let expected = expectation(description: "country data")
        countryViewModel.getDataFromApi { (error) in
            XCTAssertNil(error)
            expected.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
