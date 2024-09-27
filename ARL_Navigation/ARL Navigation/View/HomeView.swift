//  HomeView.swift
//  ARL Navigation
//
//  Created by Danil Lugli on 27/09/24.
//

import SwiftUI

struct HomeView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.customBackground)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack {
                
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.customBackground)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("ARL Navigation")
        }
    }
}

#Preview {
    HomeView()
}
