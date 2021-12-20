//
//  FixerAPI.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 16/11/2021.
//

import Foundation

final class FixerService {
 
    // MARK: - Properties
    
    var apiSymb = "" // currency symb provided by the CurrencyViewController
    private let session: URLSession
    private let baseURL = "http://data.fixer.io/api/latest"
    private var parameters: [(String, Any)] {
        return [
            ("access_key", ApiConfig.fixerKey),
            ("symbols", apiSymb)]
    }
    
    // MARK: - Initializer
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Network managment
    
    func getRate(callback: @escaping (Result<ExchangeRate, NetworkError>) -> Void) {
        guard let rateUrl: URL  = .init (string: baseURL) else {return}
        let url: URL = encode(with: rateUrl, and: parameters)
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}

extension FixerService: URLEncodable {}
