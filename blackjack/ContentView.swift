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
    @State var cardRow = 0
    
    //Game States
    // -1 - Default
    // 0 - Win
    // 1 - Dealer Win (Lost)
    // 2 - Tie
    // 3 - Bust (Lost)

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
                num += 10
            }
            else if (temp == "Q"){
                num += 10
            }
            else if (temp == "K"){
                num += 10
            }
            else {
                num += Int(temp) ?? 0
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
                num += 10
            }
            else if (temp == "Q"){
                num += 10
            }
            else if (temp == "K"){
                num += 10
            }
            else {
                num += Int(temp) ?? 0
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
        let msg = "Player wins: \(gameWin)\nDealer wins: \(gameLost)\nTied games: \(gameTie)\nTotal games played: \(gamesPlayed)\nWin Percentage: \(((gameWin)/(gamesPlayed) * 100))"
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
                .frame(width: 175)
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
                    self.gameState = -1
                  }) {
                    Text("New Game")
                        .font(.callout)
                }.padding(.all, 10.0)
                    .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                
                //Hit Me Button
                if(self.cards != [""] && self.gameState == -1){
                    Button(action: {
                        self.cards.append(self.getCard())
                        self.getCardNum()
                        if(self.hand > 21){
                            self.gameState = 3
                            self.gameLost += 1
                        }
                      }) {
                        Text("Hit Me!")
                            .font(.callout)
                    }.padding(.all, 10.0)
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                }
                
                //Hold Button
                if(self.cards != [""] && self.gameState == -1){
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
            
            // ======================= Cards/Content ============================
            HStack{
                //Divider()
                //Display Cards
                if(self.cards != [""]){
                    HStack{
                        ForEach(self.cards, id:\.self){ card in
                            Image("\(card)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90)
                        }
    //                    for card in self.cards{
    //                        var cardRow = self.cards.count / 3
    //                        Image(card)
    //                    }
                    }.padding(.all)
                }
            }
            HStack{
                //Shows player status message at buttom
                HStack{
                    if(self.gameState == 3){
                        Text("Bust!!!")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                    }
                    else if(self.gameState == 0){
                        VStack{
                            HStack{
                                ForEach(self.dealerCards, id:\.self){ card in
                                    Image("\(card)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 90)
                                }
                            }
                            HStack{
                                Text("You Win!!!")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                            }
                        }
                        
                    }
                    else if(self.gameState == 1){
                        VStack{
                            HStack{
                                ForEach(self.dealerCards, id:\.self){ card in
                                    Image("\(card)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 90)
                                }
                            }
                            HStack{
                                Text("You Lost :(")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                            }
                        }
                    }
                    else if(self.gameState == 2){
                        VStack{
                            HStack{
                                Text("Tied Game!!")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                            }
                        }
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
