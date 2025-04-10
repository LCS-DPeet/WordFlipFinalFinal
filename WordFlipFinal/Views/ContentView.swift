//
//  ContentView.swift
//  WordFlipFinal
//
//  Created by Danika Peet on 2025-04-10.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let cardImage: String
    //Tracks if card is flipped
    var faceUp: Bool = false
    //Tracks if card is matched
    var cardMatched: Bool = false
}

struct ContentView: View {
    
    //MARK: Stored Properties:
    
    //Stores the cards in the game (empty array)
    @State private var card: [Card] = []
    //Stores the first card or nil (no card filpped)
    @State private var firstFlippedIndex: Int? = nil
    //The score for the game which can be updated later
    @State private var score = 0
    
    var body: some View {
        VStack {
            HStack {
              
                Text("Score: \(score)")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Button("New Game") {
                    newGame()
                }
                
                
                
            }
            
        }
    }
   //MARK: Functions:
    
    func newGame() {
        //The card image options
        let images = ["h","i","j","k"]
        //duplicates all images so theirs matches
        let newDeck = (images + images).shuffled().map {
            //creates the card for each image
            Card(cardImage: $0)}
        //resets cards +score, indicates no flipped card(nil)
        card = newDeck
        firstFlippedIndex = nil
        score = 0
    }
    
    //MARK: Ai assisted code
    func cardFlip(at index: Int) {
        guard !card[index].faceUp, !card[index].cardMatched else { return }
        card[index].faceUp = true
        
        if let firstIndex = firstFlippedIndex {
            if card[firstIndex].cardImage == card[index].cardImage {
                
                card[firstIndex].cardMatched = true
                card[index].faceUp = true
                score += 1
            } else {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    
                    card[firstIndex].faceUp = false
                    card[index].faceUp = false
                }
            }
            
            firstFlippedIndex = nil
        } else {
            firstFlippedIndex = index
        }
    }
}

#Preview {
    ContentView()
}
