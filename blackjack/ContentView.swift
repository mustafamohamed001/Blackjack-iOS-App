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
    @State var dealerCards = [""]
    @State var showAlert = false
    @State var gamesPlayed = 0
    @State var hand = 0
    @State var dealerHand = 0
    @State var gameLost = 0
    @State var gameWin = 0
    @State var gameTie = 0
    @State var gameState = -1

    //Functions
    //Generate Card
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
    //Determines card number equivalence of cards
    func getCardNum() -> Void {
        var num = 0
        var temp = ""
        for card in cards {
            temp = String(card.dropLast())
            if(temp == "A"){
                num += 1
            }
            else if (temp == "J"){
                num += 11
            }
            else if (temp == "Q"){
                num += 12
            }
            else if (temp == "K"){
                num += 13
            }
            else {
                num += Int(temp)!
            }
        }
        self.hand = num
        num = 0
        temp = ""
        for card in dealerCards {
            temp = String(card.dropLast())
            if(temp == "A"){
                num += 1
            }
            else if (temp == "J"){
                num += 11
            }
            else if (temp == "Q"){
                num += 12
            }
            else if (temp == "K"){
                num += 13
            }
            else {
                num += Int(temp)!
            }
        }
        self.dealerHand = num
    }
    //Show Statistics msg
    func showStats() -> String {
        if(gamesPlayed == 0){
            let msg = "Player wins: \(gameWin)\nDealer wins: \(gameLost)\nTied games: \(gameTie)\nTotal games played: \(gamesPlayed)\nWin Percentage: \(((gameWin)/(1) * 100))"
            return msg
        }
        let msg = "Player wins: \(gameWin)\nDealer wins: \(gameLost)\nTied games: \(gameTie)\nTotal games played: \(gamesPlayed-1)\nWin Percentage: \(((gameWin)/(gamesPlayed) * 100))"
        return msg
    }
    //Player Hold/Dealer
    func playerHold() -> Void {
        self.dealerCards = [self.getCard(), self.getCard()]
        getCardNum()
        while(dealerHand <= 15){
            self.dealerCards.append(self.getCard())
            getCardNum()
        }
        if(self.hand > self.dealerHand || self.dealerHand > 21){
            self.gameWin += 1
            self.gameState = 0
        }
        else if(self.dealerHand > self.hand){
            self.gameLost += 1
            self.gameState = 1
        }
        else if(dealerHand == hand){
            self.gameTie += 1
            self.gameState = 2
        }
    }
    
    //App View
    var body: some View {

        VStack {
            if(self.cards == [""]){
                Image("purple_back")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
            }
            else{
                Image("purple_back")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 125)
            }
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
                    self.cards = [self.getCard(), self.getCard()]
                    self.dealerCards = [""]
                    self.gamesPlayed += 1
                  }) {
                    Text("New Game")
                        .font(.callout)
                }.padding(.all, 10.0)
                    .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                
                //Hit Me Button
                if(self.cards != [""]){
                    Button(action: {
                          self.cards.append(self.getCard())
                      }) {
                        Text("Hit Me!")
                            .font(.callout)
                    }.padding(.all, 10.0)
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                }
                
                //Hold Button
                if(self.cards != [""]){
                    Button(action: {
                        self.playerHold()
                      }) {
                        Text("Hold")
                            .font(.callout)
                    }.padding(.all, 10.0)
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                }
                
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
                        Alert(title: Text("Statistics"), message: Text("\(showStats())"))
                }
            }
            if(self.cards != [""]){
                HStack{
                        ForEach(cards, id:\.self){ card in
                            Image("\(card)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        }
                }
            }
        }.background(Image("green_felt"))
    }
}

//Debug
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
