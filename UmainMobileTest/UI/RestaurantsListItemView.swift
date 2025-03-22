//
//  RestaurantsListItemView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 22/03/25.
//

import SwiftUI

struct RestaurantsListItemView: View {
    
    var restaurant: Restaurant
    var dataManager: DataManager
    
    @State var image: UIImage?
    
    var body: some View {
        
        NavigationLink {
            
            RestaurantDetailView(restaurant: restaurant, image: image, dataManager: dataManager)
        } label: {
            
            RestaurantCardView(restaurant: restaurant, image: $image)
                
        }
    }
}

#Preview {
    NavigationStack {
        RestaurantsListItemView(restaurant: .Mock.emiliasRestaurant, dataManager: DataManager())
    }
}
