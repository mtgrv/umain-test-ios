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
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case rating
        case filterIds
        case image_url
        case delivery_time_minutes
    }
    
    // Filters
    var filters: [Filter] = []
    
    var filtersDescription: String? {
        guard !filters.isEmpty else { return nil }
        
        return filters.map({$0.name}).joined(separator: " · ")
    }
}
