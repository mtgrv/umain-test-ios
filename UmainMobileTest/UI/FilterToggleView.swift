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
            filter.isEnabled.toggle()
        } label: {
            HStack {
                
                AsyncImage(url: filter.image_url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                
                Text(filter.name)
            }
        }
        .padding(.trailing, 20)
        .background(filter.isEnabled ? Color(uiColor: .label) : Color(uiColor: .systemBackground))
        .clipShape(Capsule())
    }
}

#Preview {
    
    @Previewable @State var filter = Filter.Mock.tpoRatedFilter
    Color.secondary.opacity(0.5).ignoresSafeArea()
        .overlay(
            FilterToggleView(filter: $filter)
        )
}
