//
//  ContentView.swift
//  blackjack
//
//  Created by Mustafa Mohamed on 12/21/19.
//  Copyright © 2019 Mustafa Mohamed. All rights reserved.
//
//  Playing card image reference
//  http://acbl.mybigcommerce.com/52-playing-cards/

import SwiftUI

struct ContentView: View {
    
    //Variables
    @State var cards = [""]
    @State var showAlert = false
    @State var gamesPlayed = 0
    var hand = 0
    var dealerHand = 0
    var gameLost = 0
    var gameWin = 0
    var gameTie = 0
    
    //Functions
    func getCard() -> String {
        let card = Int.random(in: 1..<14)
        if(card == 11){
            return "JS"
        }
        else if(card == 12){
            return "QS"
        }
        else if(card == 13){
            return "KS"
        }
        else if(card == 1){
            return "AS"
        }
        return String(card) + "S"
    }
    func showStats() -> String {
        if(gamesPlayed == 0){
            let msg = "Player wins: \(gameWin)\nDealer wins: \(gameLost)\nTied games: \(gameTie)\nTotal games played: \(gamesPlayed)\nWin Percentage: \(((gameWin)/(1) * 100))"
            return msg
        }
        let msg = "Player wins: \(gameWin)\nDealer wins: \(gameLost)\nTied games: \(gameTie)\nTotal games played: \(gamesPlayed-1)\nWin Percentage: \(((gameWin)/(gamesPlayed) * 100))"
        return msg
    }
    
    //App View
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
                //New Game Button
                Button(action: {
                    self.cards = [self.getCard()]
                    self.gamesPlayed += 1
                  }) {
                    Text("New Game")
                        .font(.callout)
                }.padding(.all, 10.0)
                    .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                
                //Hit Me Button
                Button(action: {
                      self.cards.append(self.getCard())
                  }) {
                    Text("Hit Me!")
                        .font(.callout)
                }.padding(.all, 10.0)
                	.accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                	.border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                
                //Stats Button
                Button(action: {
                      self.showAlert = true
                  }) {
                    Text("Stats")
                        .font(.callout)
                }.padding(.all, 10.0)
                    .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Stats"), message: Text("\(showStats())"))
                }
            }
            HStack{
                ForEach(cards, id:\.self){ card in
                    Image("\(card)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                }
            }.padding(.all)
        }.background(Image("green_felt"))
    }
}

//Debug
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
