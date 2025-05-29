//
//  WeatherService.swift
//  1221SystemTestProject
//
//  Created by Nikita Chekmarev on 29.05.2025.
//
import Foundation

enum WeatherError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

class WeatherService {
    private let apiKey = "39f97b3a3059405da92111437252905"
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json"
    
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse {
        print("Constructing URL for city: \(city)")
        guard var components = URLComponents(string: baseURL) else {
            print("Failed to create URL components")
            throw WeatherError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "5")
        ]
        
        guard let url = components.url else {
            print("Failed to create URL from components")
            throw WeatherError.invalidURL
        }
        
        print("Making request to URL: \(url.absoluteString)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                throw WeatherError.invalidResponse
            }
            
            print("Received response with status code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Invalid status code: \(httpResponse.statusCode)")
                throw WeatherError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(WeatherResponse.self, from: data)
            print("Successfully decoded response")
            return result
        } catch let error as DecodingError {
            print("Decoding error: \(error)")
            throw WeatherError.decodingError(error)
        } catch {
            print("Network error: \(error)")
            throw WeatherError.networkError(error)
        }
    }
}


