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
            Text("Building:").font(.largeTitle)
            Text(locationProvider.building?.name ?? "")
            //Text(locationProvider.building?.floors.count ?? 99)
            //Text(locationProvider.building?.floors[0].rooms.count)
            Text("Floors:").font(.title)
            Text(locationProvider.building?.floors[0].name ?? "")
            Text("Rooms:").font(.title2)
            Text(locationProvider.building?.floors[0].rooms[0].name ?? "")
            Text(locationProvider.building?.floors[0].rooms[1].name ?? "")
            Text("Scene:").font(.title3)
            Text(locationProvider.building?.floors[0].scene.description ?? "PINO")
            Text(locationProvider.building?.floors[0].rooms[1].scene.description ?? "GINO")
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.customBackground)
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Location View")
            .navigationBarTitleDisplayMode(.inline)
    }
       
}

