//
//  ContentView.swift
//  rockpaperscissors
//
//  Created by mithun srinivasan on 14/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var RPSArray = ["rock","paper","scissors"]
    @State private var WinLose = ["win","loose"].shuffled()
    @State private var gameOver = "Game is over"

    @State private var isGameOver = false
    @State private var newVariable = 0
    var goodNumber: Int{
        if WinLose[0] == "win"{
            if correctAnswer == 2{
                return 0
            }else { return correctAnswer + 1 }
        }
        else{
            if correctAnswer == 2{
                return 1
            } else if correctAnswer == 1 { return 0}
            else {return 2}
        }
    }
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    @State private var scoreValue = 0
    
    @State private var correctAnswer = Int.random(in: 0..<3)

    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.1,green:0.2,blue:0.45), location: 0.3),
                .init(color: Color(red:0.76,green:0.20,blue:0.20), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                
                Text("computer has chosen")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                    .padding()
                Text("\(RPSArray[correctAnswer])")
                    .foregroundStyle(.primary)
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .padding()
                Text("to \(WinLose[0]):")
                    .padding().padding()
                HStack{
                    ForEach(0..<3){ number in
                        Button{
                            whenTapped(number)
                        }label: {
                            Text("\(RPSArray[number])")
                                .padding()
                                .foregroundColor(.white)
                                .background(.red)
                                .clipShape(Capsule())
                                .shadow(radius: 15)
                        }
                    }
                    .alert(scoreTitle, isPresented: $showingScore){
                        Button("continue", action: askQuestion)
                    }
                    .alert(gameOver, isPresented: $isGameOver){
                        Button("reset", action: resetting)
                    }message: {
                        Text("your final score is \(scoreValue)")
                    }
                    
                }
                .padding().padding().padding()
                Text("your final score is: \(scoreValue)")
            }
        }
    }
    func whenTapped (_ number: Int){
        if number == goodNumber{
            scoreTitle = "correct"
            scoreValue += 1
            askQuestion()
        }
        else{
            scoreTitle = "wrong"
            scoreValue -= 1
            askQuestion()
        }
        showingScore = true
        newVariable += 1
        
        if newVariable == 3{
            isGameOver = true
        }
        }

    func askQuestion (){
        WinLose.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    func resetting(){
        scoreValue = 0
        newVariable = 0
        WinLose.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
