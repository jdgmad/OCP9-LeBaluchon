//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 22/11/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //  MARK: - PROPERTIES & OUTLETS
    
    private let service = WeatherService()

    @IBOutlet weak var originCityName: UITextField!
    @IBOutlet weak var originCountryName: UITextField!
    @IBOutlet weak var temperatureOriginCity: UITextField!
    @IBOutlet weak var originWeatherIcon: UIImageView!
    @IBOutlet weak var originWeatherDescription: UITextField!
    
    
    @IBOutlet weak var destinationCityName: UITextField!
    @IBOutlet weak var destinationCountryName: UITextField!
    @IBOutlet weak var temperatureDestinationCity: UITextField!
    @IBOutlet weak var destinationWeatherIcon: UIImageView!
    @IBOutlet weak var destinationWeatherDescription: UITextField!
    @IBOutlet weak var updateWeatherButton: UIButton!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    
    //  MARK: - IBACTIONS
    
    @IBAction func updateWeatherButtonTapped() {
        updateWeather() }
    

    //  MARK: - OVERRIDES
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWeather() // Weather is updated each time the view appears
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherActivityIndicator.isHidden = true
    }
 
    //  MARK: - METHODS
  
    func updateWeather() {
        toggleActivityIndicator(visible: true, activityIndicator: weatherActivityIndicator, button: updateWeatherButton)
        service.getWeather { [weak self] result in // retain cycle
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.update(weatherData: data)
                case .failure(let error):
                    self?.presentAlert(message: "Network error : \(error)")
                }
            }
        }
    }
    
    private func update(weatherData: WeatherForecast) {
        // update champ storyboard
        toggleActivityIndicator(visible: false, activityIndicator: weatherActivityIndicator, button: updateWeatherButton)
        
        // Check if received 2 City forcast
        if weatherData.cnt != 2  {
            presentAlert(message: "Did not receive 2 city forecast")
            return
        } 
        
        // Update origin weather forecast
        originCityName.text = weatherData.list[0].name
        originCountryName.text = weatherData.list[0].sys.country
        temperatureOriginCity.text = weatherData.list[0].main.temp.getStringValue(withFloatingPoints: 1) + "°"
        originWeatherDescription.text = weatherData.list[0].weather[0].weatherDescription
        // Only show day icon by replacing the letter "n" by "d" in the icon name
        let originIconName = weatherData.list[0].weather[0].icon.replacingOccurrences(of: "n", with: "d")
        originWeatherIcon.image = UIImage(named: String(originIconName))
        
        // Update destination weather forecast
        destinationCityName.text = weatherData.list[1].name
        destinationCountryName.text = weatherData.list[1].sys.country
        temperatureDestinationCity.text = weatherData.list[1].main.temp.getStringValue(withFloatingPoints: 1) + "°"
        destinationWeatherDescription.text = weatherData.list[1].weather[0].weatherDescription
        // Only show day icon by replacing the letter "n" by "d" in the icon name
        let destinationIconName = weatherData.list[1].weather[0].icon.replacingOccurrences(of: "n", with: "d")
        destinationWeatherIcon.image = UIImage(named: String(destinationIconName))
    }
}
