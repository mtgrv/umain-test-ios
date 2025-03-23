//
//  FilterToggleView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct FilterToggleView: View {
    
    @Binding var filter: Filter
    
    var body: some View {
        
        Button {
            withAnimation {
                filter.isEnabled.toggle()
            }
        } label: {
            HStack {
                
                AsyncImage(url: filter.image_url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
                
                Text(filter.name)
                    .font(.headline)
                    .foregroundColor(filter.isEnabled ? .lightText : .darkText)
            }
        }
        .padding(.trailing, 20)
        .background(filter.isEnabled ? .accent : .white)
        .clipShape(Capsule())
        .customShadow()
    }
}

#Preview {
    
    @Previewable @State var filter = Filter.Mock.topRated
    Color.secondary.opacity(0.5).ignoresSafeArea()
        .overlay(
            FilterToggleView(filter: $filter)
                .frame(width: 200, height: 50)
        )
}
