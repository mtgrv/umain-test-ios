//
//  RestaurantsListView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantsListView: View {
    
    @Bindable private var dataManager = DataManager()
    
    var body: some View {
                
        NavigationView {
            
            ZStack {
                
                if dataManager.isLoading {
                    
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else {
                
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            
                            Spacer(minLength: 60)
                            
                            ForEach(filteredRestaurants) { restaurant in
                                
                                RestaurantsListItemView(restaurant: restaurant, dataManager: dataManager)
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.hidden)
                    
                    VStack {
                        ScrollView(.horizontal) {
                            LazyHStack {
                                
                                ForEach($dataManager.filters) { $filter in
                                    FilterToggleView(filter: $filter)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .scrollIndicators(.hidden)
                        .frame(height: 60)

                        Spacer()
                    }
                }
            }
            .background(Color.background)
        }
        .task {
            await dataManager.fetchData()
        }
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
    RestaurantsListView()
}
