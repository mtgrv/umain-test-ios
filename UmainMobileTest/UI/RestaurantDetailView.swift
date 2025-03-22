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
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isOpen: Bool?

    var body: some View {
        
        ZStack(alignment: .top) {
             
            Color.background
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
                    .foregroundStyle(.darkText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let filtersDescription = restaurant.filtersDescription {
                    
                    Text(filtersDescription)
                        .foregroundStyle(.subtitle)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if let isOpen {
                    Text(isOpen ? "Open" : "Closed")
                        .font(.title2)
                        .foregroundStyle(isOpen ? .positive : .negative)
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
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable().scaledToFit()
                        .foregroundStyle(.accent)
                        .padding(10)
                        .frame(width: 40)
                        .background(
                            Circle().fill(.white)
                                .opacity(0.9)
                        )
                }
            }
        }
        .task {
            let isOpen = await dataManager.isRestaurantOpen(restaurant)
            withAnimation {
                self.isOpen = isOpen
            }
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
