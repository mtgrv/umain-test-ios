//
//  MainView.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import SwiftUI

struct MainView: View {
    
    @Bindable private var dataManager = DataManager()
    @State private var isErrorPresented = false
    @State private var error: Error?
    
    var body: some View {
                
        NavigationStack {
            
            let topSpacing: CGFloat = 60
            
            ZStack {
                
                if dataManager.isLoading {
                    
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else {
                
                    RestaurantsListView(dataManager: dataManager, topSpacing: topSpacing)
                    
                    VStack {
                        
                        FiltersView(filters: $dataManager.filters, height: topSpacing)
                        
                        Spacer()
                    }
                }
            }
            .background(Color.background)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("umainLogo")
                        .resizable().scaledToFit()
                        .frame(height: 64)
                }
            }
        }
        .task {
            let result = await dataManager.fetchData()
            
            if case let .failure(error) = result {
                self.error = error
                self.isErrorPresented = true
            }
        }
        .alert("Error!", isPresented: $isErrorPresented, presenting: error) { _ in
            Button("OK") { }
        } message: { error in
            let message = "Something went wrong: " + String(describing: error)
            Text(message)
        }
    }
}

#Preview {
    MainView()
}
