//
//  Weather.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 22/11/2021.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.

struct WeatherForecast: Codable {
    let cnt: Int
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let sys: Sys
    let weather: [Weather]  // Include weather description
    let main: Main          // Include Temp
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case temp

    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
    
    //let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
    
// MARK: - Sys
struct Sys: Codable {
    let country: String
}

