//
//  LocationView.swift
//  ARL Navigation
//
//  Created by Danil Lugli on 10/10/24.
//

import SwiftUI
import MARS
import ARKit

struct LocationView: View {
    
    var locationProvider: LocationProvider
    
    var body: some View {
        VStack {
            Text("Welcome to LocationView")
                .font(.title)
                .padding()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.customBackground)
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Location View")
            .navigationBarTitleDisplayMode(.inline)
    }
       
}

