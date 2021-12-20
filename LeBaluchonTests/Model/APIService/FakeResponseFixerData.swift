//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by José DEGUIGNE on 07/12/2021.
//

import Foundation
import LeBaluchon

class FakeResponseFixerData {
    
    
    // MARK: - CORRECT DATA:
    // Creating fake correct data for each API Service to be tested
    static var correctData: Data? {
        let bundle = Bundle(for: FakeResponseFixerData.self)
        let url = bundle.url(forResource: "fixerAPI", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    // MARK: - INCORRECT DATA:
    static let incorrectData = "error".data(using: .utf8)!

    
    // MARK: - ERROR:
    class NetworkError: Error {}
    static let error = NetworkError()
    
    
    // MARK: - RESPONSE:

    static let url: URL = URL(string: "http://data.fixer.io/api/latest?access_key=\(ApiConfig.fixerKey)&symbols=")!
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io/api/latest?access_key=\(ApiConfig.fixerKey)a&symbols=")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io/api/latest?access_key=\(ApiConfig.fixerKey)&symbols=")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
}
