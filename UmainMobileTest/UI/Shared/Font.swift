//
//  Font.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 24/03/25.
//

import Foundation
import SwiftUI

extension Font {
    
    enum umain {
        
        // card
        static let title1 = Font.custom("Helvetica", size: 18)
        static let subtitle1 = Font.custom("Helvetica", size: 12).weight(.semibold)
        static let footer1 = Font.custom("Helvetica", size: 10)
        
        // filter
        static let title2 = Font.custom("Helvetica", size: 14).weight(.medium)
        
        //detail
        static let headline1 = Font.custom("Helvetica", size: 24)
        static let headline2 = Font.custom("Helvetica", size: 16)
    }
}
