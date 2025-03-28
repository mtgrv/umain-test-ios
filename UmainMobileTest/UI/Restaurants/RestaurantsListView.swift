//
//  RestaurantsListView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 22/03/25.
//

import SwiftUI

struct RestaurantsListView: View {
    
    var dataManager: DataManager
    var topSpacing: CGFloat
    
    var body: some View {
                
        ScrollView {
            LazyVStack(spacing: 20) {
                
                Spacer(minLength: topSpacing)
                
                if !filteredRestaurants.isEmpty {
                    ForEach(filteredRestaurants) { restaurant in
                        
                        RestaurantsListItemView(restaurant: restaurant, dataManager: dataManager)
                    }
                }
                
                else {
                    
                    Text("Cannot find restaurants matching selected filters")
                        .font(.umain.title1)
                        .foregroundStyle(.subtitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
    private var filteredRestaurants: [Restaurant] {
        
        let activeFilters = dataManager.filters.filter(\.isEnabled).map(\.id)
        
        guard !activeFilters.isEmpty else {
            return dataManager.restaurants
        }
                
        return dataManager.restaurants.filter { restaurant in
            
            for id in activeFilters {
                guard restaurant.filterIds.contains(id) else {
                    return false
                }
            }
            
            return true
        }
    }
}

#Preview {
    
    @Previewable @State var dataManager = DataManager()
    
    NavigationStack {
        RestaurantsListView(dataManager: dataManager, topSpacing: 0)
    }
    .task {
        await dataManager.fetchData()
    }
}
