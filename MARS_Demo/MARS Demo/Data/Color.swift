//
//  Color.swift
//  ARL Navigation
//
//  Created by Danil Lugli on 05/07/24.
//

import Foundation
import SwiftUI

extension Color {
    static let customBackground = Color(red: 0x1A / 255, green: 0x37 / 255, blue: 0x61 / 255)
    
    func toUIColor() -> UIColor {
        let uiColor = UIColor(self)
        return uiColor
    }
    
}

