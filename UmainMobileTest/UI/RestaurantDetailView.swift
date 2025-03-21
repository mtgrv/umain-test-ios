//
//  RestaurantDetailView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    var restaurant: Restaurant
    
    var body: some View {
        Text(restaurant.name)
    }
}

#Preview {
    NavigationView {
        RestaurantDetailView(
            restaurant: .init(id: "", name: "Restaurant name", rating: 2,
                              filterIds: [], image_url: URL(string: "https://")!, delivery_time_minutes: 30)
        )
    }
}
