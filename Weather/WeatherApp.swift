//
//  WeatherApp.swift
//  Weather
//
//  Created by Nikunj Thakur on 2024-05-29.
//

import SwiftUI

@main
struct WeatherApp: App   {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            WeatherView(viewModel: WeatherViewModel(weatherService: weatherService))
        }
    }
}
