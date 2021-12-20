//
//  FakeResponseTranslateData.swift
//  LeBaluchonTests
//
//  Created by José DEGUIGNE on 14/12/2021.
//

import Foundation
import LeBaluchon

class FakeResponseTranslateData {
           
    // MARK: - CORRECT DATA:
    // Creating fake correct data for each API Service to be tested
    static var correctData: Data? {
        let bundle = Bundle(for: FakeResponseTranslateData.self)
        let url = bundle.url(forResource: "deeplAPI", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    // MARK: - INCORRECT DATA:
    static let incorrectData = "error".data(using: .utf8)!

    
    // MARK: - ERROR:
    class NetworkError: Error {}
    static let error = NetworkError()
    
    
    // MARK: - RESPONSE:

    static let url: URL = URL(string: "https://api-free.deepl.com/v2/translate?auth_key=\(ApiConfig.deeplKey)&target_lang=&text=")!
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://api-free.deepl.com/v2/translate?auth_key=\(ApiConfig.deeplKey)&target_lang=&text=")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://api-free.deepl.com/v2/translate?auth_key=\(ApiConfig.deeplKey)&target_lang=&text=")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
}

