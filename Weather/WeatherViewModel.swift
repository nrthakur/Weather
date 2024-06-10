//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Nikunj Thakur on 2024-06-04.
//

import Foundation

private let defaultIcon = "❓"
private let iconMap = [
    "Drizzle" : "🌧️",
    "Thunderstorm" : "⛈️",
    "Rain" : "🌧️",
    "Snow" : "❄️",
    "Clear" : "☀️",
    "Clouds" : "☁️",
]

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temp: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    @Published var shouldShowLocationError: Bool = false
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
        
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather, error in
              DispatchQueue.main.async {
                if let _ = error {
                    self.shouldShowLocationError = true
                    return
                }
                
                self.shouldShowLocationError = false
                guard let weather = weather else { return }
                self.cityName = weather.city
                self.temp = "\(weather.temp)°C"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
}
