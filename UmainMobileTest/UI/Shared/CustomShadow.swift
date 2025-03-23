//
//  CustomShadow.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 23/03/25.
//

import Foundation
import SwiftUI

fileprivate struct CustomShadow: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 4, y: 4)
    }
}

extension View {
    func customShadow() -> some View {
        modifier(CustomShadow())
    }
}
