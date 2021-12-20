//
//  Translate.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 29/11/2021.
//

import Foundation

// MARK: - Welcome
struct TranslateLang: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let detectedSourceLanguage, text: String

    enum CodingKeys: String, CodingKey {
        case detectedSourceLanguage = "detected_source_language"
        case text
    }
}
