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
    
    @State private var results = [Total]()
    
    var body: some View {
        
        List(results, id: \.id) { item in
            
            LeaderRow(name: item.name, amount: item.amount / 100)
        }
        .onAppear {
            
            self.loadData()
        }
        
    }
    
    func loadData(){
        
    guard let url = URL(string: "https://tippler-chicago-api.azurewebsites.net/tip") else {
        print("Invalid URL")
        return
    }
    
    let request = URLRequest(url: url)
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            let status = (response as! HTTPURLResponse).statusCode
            
            print("Response status was: \(status)")
            
            if let data = data {
                
                print("Got data.")
                
                if let decodedResponse = try? JSONDecoder().decode(Totals.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.totals
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
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


//{"totals":[{"id":1,"name":"Lemming's","amount":5200},{"id":2,"name":"Green Eye","amount":200}]}

struct Totals: Codable {
    var totals: [Total]
}
struct Total: Codable {
    var id: Int
    var name: String
    var amount: Int
}

struct ContentView: View {
    
    var body: some View {
        VStack(){
            
            Text("Tippler")
                .padding()
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                
                
            
            //ImageView()
            
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
