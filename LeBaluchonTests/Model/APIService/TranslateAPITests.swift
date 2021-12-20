//
//  TranslateAPITests.swift
//  LeBaluchonTests
//
//  Created by José DEGUIGNE on 14/12/2021.
//

import XCTest
@testable import LeBaluchon

class TranslateAPITests: XCTestCase {

    // MARK: - Properties

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // ERROR:
    func testGetRate_WhenError_ShouldThrowAnError() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseTranslateData.url: (nil, nil, FakeResponseTranslateData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        // When
        sut.getTranslation { result in // asynchronous block of code from here
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
        URLProtocolFake.fakeURLs = [FakeResponseTranslateData.url: (nil, FakeResponseTranslateData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getTranslation { result in // asynchronous block of code from here
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
        URLProtocolFake.fakeURLs = [FakeResponseTranslateData.url: (FakeResponseTranslateData.correctData, FakeResponseTranslateData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getTranslation { result in // asynchronous block of code from here
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
        URLProtocolFake.fakeURLs = [FakeResponseTranslateData.url: (FakeResponseTranslateData.correctData, FakeResponseTranslateData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getTranslation { result in // asynchronous block of code from here
            guard case .success(let data) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
        // Then
            XCTAssertNotNil(data.translations)
            expectation.fulfill()   // we indicate here that the background task has finished successfully
        }
        wait(for: [expectation], timeout: 0.01) // As long as the background task fulfills the expectation within the 0,05 second timeout, test will pass.
     
    }
    


}


