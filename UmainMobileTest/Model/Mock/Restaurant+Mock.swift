//
//  Restaurant+Mock.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

extension Restaurant {
    
    enum Mock {
        
        static let emiliasRestaurant: Restaurant = .init(
            id: "1",
            name: "Emilia's Restaurant",
            rating: 4.9,
            filterIds: [
                "123456789", "789456123"
            ],
            image_url: URL(string: "https://picsum.photos/500/200")!,
            delivery_time_minutes: 30,
            filters: [
                .init(id: "123456789", name: "Take-Out", image_url: URL(string:"https://picsum.photos/100/100")!),
                .init(id: "789456123", name: "Fast Delivery", image_url: URL(string: "https://picsum.photos/100/100")!)
            ]
        )
    }
}
