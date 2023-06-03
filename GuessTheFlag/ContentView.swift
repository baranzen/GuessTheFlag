//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Baran Zengeralp on 5/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var questionFinal = 1
    @State private var showingFinal = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops:[
                .init(color: Color("color1"), location: 0.3),
                .init(color:Color("color3"), location: 0.3)
            ],center: .top, startRadius: 72, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(Color("color2"))
                
                
                VStack (spacing: 30){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.bold())
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label:{
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        
                    }
                    
                }
                
                .padding(.vertical, 20)
                .padding(.horizontal, 25)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Spacer()
                Text("Your score is: \(score)")
                    .foregroundColor(Color("color5"))
                    .bold()
                    .font(.title2)
                    .shadow(radius: 0.7)
            }
            
            
        }
        .alert("Wrong! That’s the flag of \(countries[correctAnswer])",isPresented: $showingScore){
            Button("Continue",action: restart)
        }message: {
            Text("Your score is \(score)")
        }
        
        .alert("Done", isPresented: $showingFinal){
            Button("Restart", action: restart)
        }message: {
            Text("game has done!")
        }
        
    }
  
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score+=1
            askQuestion()
        }else{
            scoreTitle = "Wrong"
            showingScore = true
        }
        
        if questionFinal==8{
            showingFinal = true
        }
        else{
            questionFinal+=1
        }
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart (){
        score = 0
        questionFinal = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
