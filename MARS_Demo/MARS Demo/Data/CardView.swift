//
//  CardView.swift
//  ARL Navigation
//
//  Created by Danil Lugli on 09/10/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    var name: String
    var rowSize: Int
    var isSelected: Bool
    
    init(name: String, rowSize: Int = 1, isSelected: Bool = false) {
        self.name = name
        self.rowSize = rowSize
        self.isSelected = isSelected
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.green : Color.clear, lineWidth: 6)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding()
            
        }
        .frame(width: 360 / CGFloat(rowSize), height: 80)
        .padding()
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(name: "Building", rowSize: 1, isSelected: false)
    }
}
