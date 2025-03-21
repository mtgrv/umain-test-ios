//
//  RestaurantsListView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantsListView: View {
    
    @State private var dataManager = DataManager()
    
    var body: some View {
        
        NavigationView {
            
            if dataManager.isLoading {
                
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else {
                List(dataManager.restaurants) { restaurant in
                    
                    NavigationLink {
                        
                        RestaurantDetailView(restaurant: restaurant)
                    } label: {
                        
                        RestaurantCardView(restaurant: restaurant)
                    }
                }
            }
        }
        .task {
            await dataManager.fetchData()
        }
    }
}

#Preview {
    RestaurantsListView()
}
