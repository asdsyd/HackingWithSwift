//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Asad Sayeed on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userScore = 0
    @State private var questionsDisplayed = 0
    @State private var restartTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionsDisplayed == 8 {
                Button("Restart", action: resetGame)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            if questionsDisplayed == 8 {
                Text("Your score is: \(userScore)/8")
            }
        }
    }
            
            
            func flagTapped(_ number: Int) {
                if number == correctAnswer {
                    scoreTitle = "Correct! You reached the End of Game!"
                    userScore += 1
                    askQuestion()
                } else {
                    scoreTitle = "Wrong! That's the flag of \(countries[number])"
                    showingScore = true
                    askQuestion()
                }
                
//                showingScore = true
                questionsDisplayed += 1
                
                if questionsDisplayed == 8 {
                    showingScore = true
                }
            }
            
            func askQuestion() {
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
            }
    
            func resetGame() {
                userScore = 0
                questionsDisplayed = 0
            }
        }


#Preview {
    ContentView()
}
