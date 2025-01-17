//
//  ContentView.swift
//  Proj-2-GuessTheFlag
//
//  Created by Palwinder Singh on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var answer = 0
    @State private var chances = 7
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
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
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                }
                Spacer()
                Spacer()
                HStack {
                    Text("Your score is:")
                    Text("\(score)")
                        .font(.title.bold())
                }
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continue", action: askQuestion)
            } message: {
                if scoreTitle == "Wrong"{
                    Text("Wrong! thats the flag of \(countries[answer])")
                }
                Text("Your score is \(score)")
            }
            .alert("Game Over", isPresented: $showingGameOver){
                Button("Play Again", action: reset)
                } message: {
                    Text("Your final score is: \(score)")
                }
            
           
        }
        
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        } else{
            scoreTitle = "Wrong"
        }
        chances = chances - 1
        answer = number
        
        if chances == 0 {
            showingGameOver = true
        }
        else {
            showingScore = true
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func reset(){
        score = 0
        chances = 8
        askQuestion()
    }
}

#Preview {
    ContentView()
}
