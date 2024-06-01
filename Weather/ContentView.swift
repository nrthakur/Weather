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

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Project Update")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
