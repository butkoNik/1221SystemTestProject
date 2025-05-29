//
//  WeatherView.swift
//  1221SystemTestProject
//
//  Created by Nikita Chekmarev on 29.05.2025.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter city name", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            viewModel.updateCity(searchText)
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)
                
                Text("Current city: \(viewModel.currentCity)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .onAppear {
                                print("Loading state")
                            }
                    } else if let error = viewModel.error {
                        VStack {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                            Button("Retry") {
                                viewModel.fetchWeather()
                            }
                        }
                        .onAppear {
                            print("Error state: \(error)")
                        }
                    } else {
                        List(viewModel.forecastDays) { day in
                            WeatherDayRow(forecastDay: day)
                        }
                        .onAppear {
                            print("List state with \(viewModel.forecastDays.count) days")
                        }
                    }
                }
            }
            .navigationTitle("Weather Forecast")
        }
        .onAppear {
            print("WeatherView appeared")
            viewModel.fetchWeather()
        }
    }
}

struct WeatherDayRow: View {
    let forecastDay: ForecastDay
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(formatDate(forecastDay.date))
                .font(.headline)
            
            HStack {
                AsyncImage(url: URL(string: "https:\(forecastDay.day.condition.icon)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(forecastDay.day.condition.text)
                        .font(.subheadline)
                    Text("Temperature: \(Int(forecastDay.day.avgtemp_c))°C")
                    Text("Wind: \(Int(forecastDay.day.maxwind_kph)) km/h")
                    Text("Humidity: \(Int(forecastDay.day.avghumidity))%")
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
    }
}

//#Preview {
//    WeatherView()
//}
