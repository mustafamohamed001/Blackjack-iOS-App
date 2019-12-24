//
//  ContentView.swift
//  blackjack
//
//  Created by Mustafa Mohamed on 12/21/19.
//  Copyright © 2019 Mustafa Mohamed. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var somevar = "Hello World!"
    var body: some View {
        VStack {
            HStack{
                Text("Blackjack")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.all)
                    //.position(x: 210, y: 30)
            }
            HStack{
                Image("2S").resizable().aspectRatio(contentMode: .fit).frame(width: 100)
            }
        }.background(Image("green_felt"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
