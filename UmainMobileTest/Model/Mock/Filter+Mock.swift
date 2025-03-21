//
//  Filter+Mock.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

extension Filter {
    
    enum Mock {
        
        static let tpoRatedFilter: Filter = .init(
            id: "1",
            name: "Top Rated",
            image_url: URL(string: "https://picsum.photos/100/100")!
        )
    }
}
