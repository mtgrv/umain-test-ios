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
        RestaurantDetailView(restaurant: Restaurant.Mock.emiliasRestaurant)
    }
}
