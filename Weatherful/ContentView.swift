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
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
