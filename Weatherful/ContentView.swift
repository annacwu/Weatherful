//
//  ContentView.swift
//  Weatherful
//
//  Created by Anna Wu on 11/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var locationForecast: locationURL?
    @State private var Temper: Temp?
    
    var body: some View {
        Form{
            Text(Temper?.temperature ?? "temperature unavailable")
        }
        .padding()
        .task {
            do {
                locationForecast = try await getLocationURL()
            } catch GLError.invalidURL {
                print("invalid URL")
            } catch GLError.invalidResponse {
                print("invalid response")
            } catch GLError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        }
        .task {
            do {
                Temper = try await getTemp()
            } catch GLError.invalidURL {
                print("invalid URL")
            } catch GLError.invalidResponse {
                print("invalid response")
            } catch GLError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    func getTemp() async throws -> Temp{
        let endpoint = "https://api.weather.gov/gridpoints/LWX/97,71/forecast"
        
        guard let url = URL(string: endpoint) else {
            throw GLError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GLError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Temp.self, from: data)
        } catch {
            throw GLError.invalidData
        }
    }
    
    func getLocationURL() async throws -> locationURL{
        let endpoint = "https://api.weather.gov/points/38,-77"
        
        guard let url = URL(string: endpoint) else {
            throw GLError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GLError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(locationURL.self, from: data)
        } catch {
            throw GLError.invalidData
        }
    }
}

struct Temp: Codable {
    let temperature: String
}

struct locationURL: Codable {
    let forecast: String
    let forecastHourly: String
}

enum GLError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

#Preview {
    ContentView()
}
