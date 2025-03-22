//
//  RestaurantDetailView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    var restaurant: Restaurant
    var dataManager: DataManager
    
    @State private var isOpen: Bool?
    
    var body: some View {
        
        VStack(alignment : .leading) {
            
            Text(restaurant.name)
            
            if let filtersDescription = restaurant.filtersDescription {
                
                Text(filtersDescription)
                    .foregroundStyle(.secondary)
                    .font(.callout.bold())
            }
            
            if let isOpen {
                Text(isOpen ? "Open" : "Closed")
            } else {
                ProgressView()
            }
        }
        .task {
            self.isOpen = await dataManager.isRestaurantOpen(restaurant)
        }
    }
}

#Preview {
    NavigationView {
        RestaurantDetailView(restaurant: Restaurant.Mock.emiliasRestaurant, dataManager: DataManager())
    }
}
