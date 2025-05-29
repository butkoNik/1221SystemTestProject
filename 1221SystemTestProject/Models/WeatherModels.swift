//
//  WeatherModels.swift
//  1221SystemTestProject
//
//  Created by Nikita Chekmarev on 29.05.2025.
//

import Foundation


struct WeatherResponse: Codable {
    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Identifiable {
    let date: String
    let day: Day
    let hour: [Hour]
    
    var id: String { date }
}

struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let avgtemp_c: Double
    let maxwind_kph: Double
    let avghumidity: Double
    let condition: Condition
}

struct Hour: Codable {
    let time: String
    let temp_c: Double
    let condition: Condition
    let wind_kph: Double
    let humidity: Double
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}
