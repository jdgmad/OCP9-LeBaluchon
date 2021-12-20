//
//  Foudation.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 18/11/2021.
//

import Foundation

extension Double {
    
    /// Convert double in String with variable decimal points or exponant
    ///
    /// - Parameters:
    ///   - points: Give the numbers of decimal points to display
    ///
    /// If the number is over or les than 10 billions use the exponant format
    /// Otherwise If there is no fractionnal part return only the integer part
    ///
    func getStringValue(withFloatingPoints points: Int = 0) -> String {
        if self < 10000000000 && self > -10000000000 {
            let valDouble = modf(self)
            // get the fractionnal value
            let fractionalVal = (valDouble.1)
            if fractionalVal != 0 {
                return String(format: "%.*f", points, self)
            }
            return String(format: "%.0f", self)
        }
        return String(format: "%.*e", points, self)
    }
}

extension String {
    var isnumber: Bool {
        return Double(self) != nil
    }
}

extension URLComponents {
    // This func will map [String: String] parameters to URLQueryItems
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
