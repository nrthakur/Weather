//
//  Weather.swift
//  Weather
//
//  Created by Nikunj Thakur on 2024-06-01.
//

import Foundation
// Hold model data that our View-Model will use to show in the UI

public struct Weather {
    let city: String
    let temp: String
    let description: String
    let iconName: String
    
    init(response: APIResponse) {
        city = response.name
        temp = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
 
