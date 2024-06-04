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
            Text(viewModel.cityName).font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/).padding()
            Text(viewModel.temp).font(.system(size: 70)).bold()
            Text(viewModel.temp).font(.largeTitle).padding()
            Text(viewModel.weatherDescription)
        }.onAppear(perform: viewModel.refresh)
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
}
