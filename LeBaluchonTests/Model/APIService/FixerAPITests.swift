//
//  LeBaluchonTests.swift
//  LeBaluchonTests
//
//  Created by José DEGUIGNE on 09/11/2021.
//

import XCTest
@testable import LeBaluchon

class FixerAPITestCase: XCTestCase {
    
    // MARK: - Properties

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // ERROR:
    func testGetRate_WhenError_ShouldThrowAnError() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseFixerData.url: (nil, nil, FakeResponseFixerData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: FixerService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        // When
        sut.getRate { result in // asynchronous block of code from here
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
        // Then
            XCTAssertTrue(error == .noData)
            expectation.fulfill()   // we indicate here that the background task has finished successfully
        }
        wait(for: [expectation], timeout: 0.01) // As long as the background task fulfills the expectation within the 0,05 second timeout, test will pass.
    }
    
    // UNDECODABLE DATA:
    func testGetRate_WhenNoData_ShouldFail() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseFixerData.url: (nil, FakeResponseFixerData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: FixerService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getRate { result in // asynchronous block of code from here
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
        // Then
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()   // we indicate here that the background task has finished successfully
        }
        wait(for: [expectation], timeout: 0.01) // As long as the background task fulfills the expectation within the 0,05 second timeout, test will pass.
    }
    
    // INVALID RESPONSE:
    func testGetRate_WhenIncorrectResponse_ShouldFail() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseFixerData.url: (FakeResponseFixerData.correctData, FakeResponseFixerData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: FixerService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getRate { result in // asynchronous block of code from here
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
        // Then
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()   // we indicate here that the background task has finished successfully
        }
        wait(for: [expectation], timeout: 0.01) // As long as the background task fulfills the expectation within the 0,05 second timeout, test will pass.
    }
    
    
    // DATA OK, RESPONSE OK, NO ERROR:
    func testGetRate_WhenDataResponseOKnoError_ShouldSucceedandProvideData() {
        
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseFixerData.url: (FakeResponseFixerData.correctData, FakeResponseFixerData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: FixerService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getRate { result in // asynchronous block of code from here
            guard case .success(let data) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
        // Then
            XCTAssertNotNil(data.rates)
            expectation.fulfill()   // we indicate here that the background task has finished successfully
        }
        wait(for: [expectation], timeout: 0.01) // As long as the background task fulfills the expectation within the 0,05 second timeout, test will pass.
     
    }
    
     
     
}
