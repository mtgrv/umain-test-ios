//
//  Restaurant.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

struct Restaurant: Identifiable, Decodable {
    
    let id: String
    let name: String
    let rating: Double
    let filterIds: [String]
    let image_url: URL
    let delivery_time_minutes: Int
}
