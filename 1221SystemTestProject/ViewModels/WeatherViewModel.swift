//
//  WeatherViewModel.swift
//  1221SystemTestProject
//
//  Created by Nikita Chekmarev on 29.05.2025.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var forecastDays: [ForecastDay] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var currentCity: String = "Moscow"
    
    private let weatherService = WeatherService()
    
    init() {
        print("WeatherViewModel initialized")
    }
    
    func fetchWeather() {
        print("Starting weather fetch")
        isLoading = true
        error = nil
        
        Task {
            do {
                print("Making API call for city: \(currentCity)")
                let response = try await weatherService.fetchWeatherForecast(for: currentCity)
                print("Received response with \(response.forecast.forecastday.count) days")
                forecastDays = response.forecast.forecastday
            } catch {
                print("Error fetching weather: \(error)")
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func updateCity(_ city: String) {
        currentCity = city
        fetchWeather()
    }
}
