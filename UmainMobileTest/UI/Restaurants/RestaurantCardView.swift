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
        
        VStack(spacing: 0) {
            
            ZStack {
                if let image {
                    Image(uiImage: image)
                        .resizable().scaledToFill()
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(height: 160)
            .clipped()
            
            VStack(alignment: .leading, spacing: 2) {
                
                HStack {
                    
                    Text(restaurant.name)
                        .foregroundStyle(.darkText)
                        .font(.umain.title1)
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        
                        
                        if let rating = formatter.string(from: restaurant.rating as NSNumber) {
                            Text(rating)
                                .foregroundStyle(.darkText)
                        }
                    }
                    .font(.umain.footer1.weight(.medium))
                }
                
                if let filtersDescription = restaurant.filtersDescription {
                    
                    Text(filtersDescription)
                        .foregroundStyle(.subtitle)
                        .font(.umain.subtitle1)
                }
                
                HStack(spacing: 4) {
                    
                    Image(systemName: "clock")
                        .foregroundStyle(.red)
                    Text(restaurant.formattedDeliveryTime)
                        .foregroundStyle(.darkText)
                }
                .font(.umain.footer1)
            }
            .padding(10)
            .multilineTextAlignment(.leading)
        }
        .background(.white)
        .clipShape(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 16, topTrailing: 16))
        )
        .customShadow()
        .task {
            self.image = await fetchImage()
        }
    }
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.decimalSeparator = "."
        return formatter
    }()
    
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
    @Previewable @State var image: UIImage?
    
    Color.background
        .overlay(
            RestaurantCardView(restaurant: Restaurant.Mock.emiliasRestaurant, image: $image)
                .padding()
        )
    
}
