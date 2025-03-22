//
//  RestaurantCardView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantCardView: View {
    
    var restaurant: Restaurant
    @Binding var image: UIImage?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ZStack {
                if let image {
                    Image(uiImage: image)
                        .resizable().scaledToFill()
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
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
        .task {
            self.image = await fetchImage()
        }
    }
    
    private func fetchImage() async -> UIImage? {
        
        guard let (data, response) = try? await URLSession.shared.data(from: restaurant.image_url) else {
            return nil
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return nil
        }
        
        return UIImage(data: data)
    }
}

#Preview {
    RestaurantCardView(restaurant: Restaurant.Mock.emiliasRestaurant, image: .constant(nil))
        .padding()
}
