//
//  ContentView.swift
//  Weatherful
//
//  Created by Anna Wu on 11/6/23.
//

import SwiftUI

func performAPICall() async throws {
    // need lat long
    // json wrapper?
    // user id
}

struct Response: Codable{
    var result: [Result]
}

struct Result: Codable {
    var id = UUID()
    var username: String
    var name: String
}

struct ContentView: View {
    func loadData() async{
        guard let url = URL(string: "https://api.weather.gov/points/{lat},{lon}") else {
            print("Invalid URL")
            return
        }
    }
    @State private var result = [Result]()
    var body: some View {
        VStack {
//            Text(item.username)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
