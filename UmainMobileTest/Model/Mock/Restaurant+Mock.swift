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
            id: "7450007",
            name: "Emilia´s Fancy Food",
            rating: 4.1,
            filterIds: [
                "5c64dea3-a4ac-4151-a2e3-42e7919a925d",
                "23a38556-779e-4a3b-a75b-fcbc7a1c7a20",
                "0017e59c-4407-453f-a5be-901695708015"
            ],
            image_url: URL(string: "https://food-delivery.umain.io/images/restaurant/meat.png")!,
            delivery_time_minutes: 1,
            filters: [.Mock.topRated, .Mock.fastDelivery, .Mock.eatIn]
        )
    }
}
