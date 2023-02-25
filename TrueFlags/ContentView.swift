//
//  ContentView.swift
//  TrueFlags
//
//  Created by Vlad on 25.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["USA", "Ukraine", "China", "India", "Europe", "Japan"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 19){
                VStack{
                    Text("Choose flag: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTupped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                            .stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 15)
                    }
                }
                Text("Your score: \(score)")
                    .font(.headline)
                    .fontWeight(.black)
            }
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("General score \(score)"), dismissButton: .default(Text("Next")){
                self.askQuestion()
            })
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTupped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "You are right"
            score += 1
        } else {
            scoreTitle = "It is wrong"
            score -= 1
        }
        
    }
    
}



















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
