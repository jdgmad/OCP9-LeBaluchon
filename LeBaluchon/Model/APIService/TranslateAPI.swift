//
//  TranslateAPI.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 29/11/2021.
//

import Foundation

final class TranslateService {
    
    // MARK: - Properties
    
    private let translateSession: URLSession
    private let baseUrl = "https://api-free.deepl.com/v2/translate"

    var destinationLanguage = "" // destination language provided by the TranslateViewController
    var translateInput: String = "" // text to be translated provided by the TranslateViewController
    
    private var parameters: [(String,String)] {
        return [
            ("auth_key", ApiConfig.deeplKey),
            ("target_lang",self.destinationLanguage),
            ("text",self.translateInput)]
    }
    
    // MARK: - Initializer
    
    init (session: URLSession = URLSession(configuration: .default)) {
        self.translateSession = session
    }
  
    // MARK: - Network managment
    
    func getTranslation(callback: @escaping (Result<TranslateLang, NetworkError>) -> Void) {
        guard let translateUrl: URL  = .init (string: baseUrl) else {return}
        let url: URL = encode(with: translateUrl, and: parameters)
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        translateSession.dataTask(with: url, callback: callback)
    }
}

extension TranslateService: URLEncodable {}

