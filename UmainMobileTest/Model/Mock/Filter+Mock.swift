//
//  Filter+Mock.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

extension Filter {
    
    enum Mock {
        
        static let topRated: Filter = .init(
            id: "5c64dea3-a4ac-4151-a2e3-42e7919a925d",
            name: "Top Rated",
            image_url: URL(string: "https://food-delivery.umain.io/images/filter/filter_top_rated.png")!
        )
        
        static let fastDelivery: Filter = .init(
            id: "23a38556-779e-4a3b-a75b-fcbc7a1c7a20",
            name: "Fast delivery",
            image_url: URL(string: "https://food-delivery.umain.io/images/filter/filter_fast_delivery.png")!
        )
        
        static let eatIn: Filter = .init(
            id: "0017e59c-4407-453f-a5be-901695708015",
            name: "Eat-in",
            image_url: URL(string: "https://food-delivery.umain.io/images/filter/filter_eat_in.png")!
        )
    }
}
