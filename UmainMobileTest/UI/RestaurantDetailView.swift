//
//  RestaurantDetailView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    var restaurant: Restaurant
    var image: UIImage?
    var dataManager: DataManager
    
    @State private var isOpen: Bool?

    var body: some View {
        
        ZStack(alignment: .top) {
             
            Color(uiColor: .systemBackground)
                .overlay(
                    VStack {
                        
                        if let image {
                            Image(uiImage: image)
                                .resizable().scaledToFill()
                                .frame(height: 260)
                                .clipped()
                        }
                        Spacer()
                    }
                )
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(restaurant.name)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let filtersDescription = restaurant.filtersDescription {
                    
                    Text(filtersDescription)
                        .foregroundStyle(.secondary)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if let isOpen {
                    Text(isOpen ? "Open" : "Closed")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    ProgressView()
                }
            }
            .padding(20)
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 20)
            .padding(.top, 200)
            .shadow(radius: 10, y: 6)
        }
        .ignoresSafeArea()
        .task {
            self.isOpen = await dataManager.isRestaurantOpen(restaurant)
        }
    }
}

#Preview {
    NavigationView {
        RestaurantDetailView(restaurant: Restaurant.Mock.emiliasRestaurant,
                             image: UIImage(systemName: "photo.artframe"),
                             dataManager: DataManager())
    }
}
