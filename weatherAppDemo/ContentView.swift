//
//  ContentView.swift
//  weatherAppDemo
//
//  Created by Theo Marie on 26/04/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    Text("Weather data fetched !")
                    
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather =  try await weatherManager.getCurrentWeather(latitude: location.longitude, longitude: location.latitude)
                            } catch {
                                print("Error Getting weather : \(error)")
                            }
                        }
                }
                
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(red: 0.021, green: 0.031, blue: 0.207)
        )
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
