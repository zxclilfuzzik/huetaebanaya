//
//  ContentView.swift
//  weatherApps
//
//  Created by Hero Fiennes-Tiffin on 14.04.2022.
//

import SwiftUI

struct weatherView: View {
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("Los Angeles")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding()
                    Text("clear")
                        .bold()
                        .font(.title)
                    Text ("☀️")
                        .font(.largeTitle)
                        .padding()
                    Text("25")
                        .bold()
                    Spacer()
                }
                Spacer()
                VStack {
                    Divider().frame(width: 360)
                    ForEach(1 ..< 7) { item in
                        Text("Инвормация")
                        Divider().frame(width: 360)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        weatherView()
    }
}
