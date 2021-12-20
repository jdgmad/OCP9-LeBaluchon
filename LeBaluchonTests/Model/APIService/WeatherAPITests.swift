//
//  weatherAPITests.swift
//  LeBaluchonTests
//
//  Created by José DEGUIGNE on 14/12/2021.
//

import XCTest
@testable import LeBaluchon

class WeatherAPITests: XCTestCase {

    // MARK: - Properties

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // ERROR:
    func testGetRate_WhenError_ShouldThrowAnError() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (nil, nil, FakeResponseWeatherData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        // When
        sut.getWeather { result in // asynchronous block of code from here
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
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (nil, FakeResponseWeatherData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getWeather { result in // asynchronous block of code from here
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
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (FakeResponseWeatherData.correctData, FakeResponseWeatherData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getWeather { result in // asynchronous block of code from here
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
        // Then
            //XCTAssertTrue(error == nil)
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()   // we indicate here that the background task has finished successfully
        }
        wait(for: [expectation], timeout: 0.01) // As long as the background task fulfills the expectation within the 0,05 second timeout, test will pass.
    }
    
    
    // DATA OK, RESPONSE OK, NO ERROR:
    func testGetRate_WhenDataResponseOKnoError_ShouldSucceedandProvideData() {
        
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.url: (FakeResponseWeatherData.correctData, FakeResponseWeatherData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        // When
        sut.getWeather { result in // asynchronous block of code from here
            guard case .success(let data) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
        // Then
            XCTAssertNotNil(data.cnt)
            expectation.fulfill()   // we indicate here that the background task has finished successfully
        }
        wait(for: [expectation], timeout: 0.01) // As long as the background task fulfills the expectation within the 0,05 second timeout, test will pass.
     
    }
    

}
