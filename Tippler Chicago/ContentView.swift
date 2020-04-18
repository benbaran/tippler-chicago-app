//
//  ContentView.swift
//  Tippler Chicago
//
//  Created by Ben Baran on 4/15/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct ImageView: View{
        var body: some View {
            Image("tippler")
                .resizable()
                .scaledToFit()
    }
}

struct LeaderRow: View{
    
    let name: String
    let amount: Int
    
    var body: some View {
        HStack{
            
            Text(name)
                .padding().font(.title)
            
            Spacer()
            
            Text("$\(amount)")                    .
                padding().font(.title)
        }
    }
}
    
struct LeaderView: View{
    
    var body: some View {
        
        VStack(){
                
            LeaderRow(name: "Lemming's", amount: 5000)
                
            LeaderRow(name: "Green Eye", amount: 5200)
                
            LeaderRow(name: "Map Room", amount: 50)
                
            LeaderRow(name: "Lottie's", amount: 4500)
            
            LeaderRow(name: "Bucktown Pub", amount: 500)
        }
    }
}

struct TipButton: View{
    
    let amount: Int
    
    var body: some View{
        Text("$\(amount)")
        .fontWeight(.bold)
        .font(.title)
        .padding()
        .background(Color.green)
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding(10)
    }
}

struct TipView: View{
    var body: some View {
            
        VStack{
                
            HStack(){

                TipButton(amount: 5)
                    
                TipButton(amount: 3)
                    
                TipButton(amount: 2)
                    
            }
                
            TipButton(amount: 1)
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(){
            
            ImageView()
            
            LeaderView()
            
            Spacer()
            
            TipView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
