//
//  WeatherService.swift
//  Weather
//
//  Created by Nikunj Thakur on 2024-06-01.
//  File to obtain User location & retrive data from OpenWeatherMap


import Foundation
import CoreLocation // Will allow the usage of the library that helps in retriving user location
public final class WeatherService: NSObject {
    let locationManager = CLLocationManager()
    private let API_KEY = "d8a18c92765cd5906da1b1d1222c6ebf"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    // https://https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {return}
        
        guard let url = URL(string: urlString)
        else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard error == nil, let data = data else {return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager, 
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Something Went Wrong :( \(error.localizedDescription)")
    }
        
    }


// Imporing 3 structures that will represent the different JSON responses obtained from OpenWeatherMap API

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}
struct APIMain: Decodable {
    let temp: Double
}
struct APIWeather: Decodable {
    let description: String
    let iconName: String
        
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
