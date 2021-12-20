//
//  OpenWeatherAPI.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 21/11/2021.
//

import Foundation

final class WeatherService {
 
    // MARK: - Properties
    
    private let weatherSession: URLSession
    private let baseUrl = "http://api.openweathermap.org/data/2.5/group"
    private let originCityID = "5128581" // New York
    private let destinationCityID = "2988507" // Paris
    private var parameters: [(String,String)] {
        return [
            ("appid", ApiConfig.openWheatherKey),
            ("id","\(originCityID),\(destinationCityID)"),
            ("units", "metric")]
    }
    
    // MARK: - Initializer
    
    init (session: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = session
    }

    // MARK: - Network managment
    
    func getWeather(callback: @escaping (Result<WeatherForecast, NetworkError>) -> Void) {
        guard let weatherUrl: URL  = .init (string: baseUrl) else {return}
        let url: URL = encode(with: weatherUrl, and: parameters)
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        weatherSession.dataTask(with: url, callback: callback)
    }
}

extension WeatherService: URLEncodable {}
