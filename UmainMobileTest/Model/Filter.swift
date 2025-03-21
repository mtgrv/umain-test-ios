//
//  Filter.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

struct Filter: Identifiable, Decodable {
    
    let id: String
    let name: String
    let image_url: URL
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case image_url
    }
    
    var isEnabled: Bool = false
}
