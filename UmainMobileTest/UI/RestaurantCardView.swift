//
//  RestaurantCardView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantCardView: View {
    
    var restaurant: Restaurant
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            AsyncImage(url: restaurant.image_url) { image in
                image
                    .resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 100)
            .clipped()
            
            HStack {
                
                Text(restaurant.name)
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("\(restaurant.rating)")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            
            if let filtersDescription = restaurant.filtersDescription {
                
                Text(filtersDescription)
                    .foregroundStyle(.secondary)
                    .font(.callout.bold())
            }
            
            HStack(spacing: 4) {
                
                Image(systemName: "clock")
                    .foregroundStyle(.red)
                Text("\(restaurant.delivery_time_minutes)")
                    .font(.caption)
            }
        }
        
        .clipped()
    }
}

#Preview {
    RestaurantCardView(restaurant: Restaurant.Mock.emiliasRestaurant)
        .padding()
}
