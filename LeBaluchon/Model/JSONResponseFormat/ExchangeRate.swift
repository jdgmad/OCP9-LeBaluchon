//
//  ExchangeRate.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 16/11/2021.
//

import Foundation


struct ExchangeRate: Decodable {

    //let rates: Rates
    let rates: [String : Double]
}

