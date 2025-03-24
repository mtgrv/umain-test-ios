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
    
    // delivery time formatted as String
    var formattedDeliveryTime: String {
        guard delivery_time_minutes > 0 else {
            return "0 mins"
        }
        
        if delivery_time_minutes == 1 {
            return "1 min"
        }
        else if delivery_time_minutes < 60 {
            return "\(delivery_time_minutes) mins"
        }
        else if delivery_time_minutes == 60 {
            return "1 hour"
        }
        else {
            
            let hours = delivery_time_minutes / 60
            let mins = delivery_time_minutes - (hours * 60)
            
            var result = "\(hours) \(hours > 1 ? "hours" : "hour")"
            result += " \(mins) \(mins > 1 ? "mins" : "min")"
            return result
        }
    }
}
