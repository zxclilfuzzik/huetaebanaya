//
//  weatherModel.swift
//  weatherApps
//
//  Created by Hero Fiennes-Tiffin on 14.04.2022.
//

import Foundation


public struct weatherModel {
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    init(response: APIResponse) {
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
 
