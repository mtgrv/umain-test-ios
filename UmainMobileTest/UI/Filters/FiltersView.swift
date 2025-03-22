//
//  FiltersView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 22/03/25.
//

import SwiftUI

struct FiltersView: View {
    
    @Binding var filters: [Filter]
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHStack {
                
                ForEach($filters) { $filter in
                    FilterToggleView(filter: $filter)
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    @Previewable @State var filters = [Filter.Mock.eatIn, Filter.Mock.topRated]
    
    FiltersView(filters: $filters)
        .frame(height: 60)
}
