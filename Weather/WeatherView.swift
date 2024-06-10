//
//  ContentView.swift
//  Weather
//
// Created by Nikunj Thakur on 2024-05-29.
//
// Simple Weather App displaying current Weather data in current location.
// Utilizing a Model-View-View-Model (MVVM) architectural pattern
// Utilizing OpenWeatherMap API to retrive Weather Data
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
            Text(viewModel.temp)
                .font(.system(size: 70))
                .bold()
            Text(viewModel.temp)
                .font(.largeTitle)
                .padding()
            Text(viewModel.weatherDescription)
        }
        .alert(isPresented: $viewModel.shouldShowLocationError) {
            Alert(
                title: Text("Error"),
                message: Text("To see Weather, please provide location access in Settings."),
                dismissButton: .default(Text("Open Settings")) {
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
                    UIApplication.shared.open(settingsURL)
                    }
                )
            }
            .onAppear(perform: viewModel.refresh)
        }
    }

#Preview {
    WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
}
