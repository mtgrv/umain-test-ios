//
//  OpenStatus.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

extension Restaurant {
    
    struct OpenStatus: Decodable {
        
        let restaurant_id: String
        let is_currently_open: Bool
    }
}
