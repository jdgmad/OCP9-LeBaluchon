//
//  FakeResponseWeatherData.swift
//  LeBaluchonTests
//
//  Created by José DEGUIGNE on 14/12/2021.
//

import Foundation
import LeBaluchon

class FakeResponseWeatherData {
     
    // MARK: - CORRECT DATA:
    // Creating fake correct data for each API Service to be tested
    static var correctData: Data? {
        let bundle = Bundle(for: FakeResponseWeatherData.self)
        let url = bundle.url(forResource: "openWeatherAPI", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    // MARK: - INCORRECT DATA:
    static let incorrectData = "error".data(using: .utf8)!

    
    // MARK: - ERROR:
    class NetworkError: Error {}
    static let error = NetworkError()
    
    
    // MARK: - RESPONSE:

    static let url: URL = URL(string: "http://api.openweathermap.org/data/2.5/group?appid=\(ApiConfig.openWheatherKey)&id=5128581,2988507&units=metric")!
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://api.openweathermap.org/data/2.5/group?appid=\(ApiConfig.openWheatherKey)&id=5128581,2988507&units=metric")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://api.openweathermap.org/data/2.5/group?appid=\(ApiConfig.openWheatherKey)&id=5128581,2988507&units=metric")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
}
