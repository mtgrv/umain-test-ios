//
//  RestaurantsListView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantsListView: View {
    
    @State private var restaurants: [Restaurant] = []
    
    var body: some View {
        
        List(restaurants) { restaurant in
            
            Text(restaurant.name)
        }
        .task {
            restaurants = (try? await fetchRestaurants()) ?? []
        }
    }
    
    private func fetchRestaurants() async throws -> [Restaurant]? {
        
        let url = URL(string: "https://food-delivery.umain.io/api/v1/restaurants")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response = try? decoder.decode(RestaurantsResponse.self, from: data)
        
        return response?.restaurants
    }
    
    struct RestaurantsResponse: Decodable {
        
        let restaurants: [Restaurant]
    }
}

#Preview {
    RestaurantsListView()
}
