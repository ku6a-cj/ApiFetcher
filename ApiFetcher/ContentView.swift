//
//  ContentView.swift
//  ApiFetcher
//
//  Created by Jakub Chodara on 27/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    let url = "https://jsonplaceholder.typicode.com/todos"
    @State var titlee = "title"
    @State var id = 1
    @State var userId = 1
    @State var completed = false
    @State var selectedID = 1.0
    
    func testNumberAsString(_ numberAsString: String) -> NSDecimalNumber{
        let num = NSDecimalNumber.init(string: numberAsString)
        let behaviour = NSDecimalNumberHandler(roundingMode:.down, scale: 2, raiseOnExactness: false,  raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let numRounded = num.rounding(accordingToBehavior: behaviour)

        return numRounded
    }
    
    var body: some View {
        Form{
            
            Section(header: Text("URL of api")){
                Text("URL: \(url)")
            }
            
            Section(header: Text("ID Selector")){
                VStack{
                    Text("Selected ID: \(testNumberAsString("\(String(selectedID))"))")
                    
                    Slider(value: $selectedID,
                           in: 0...200,
                           step: 1
                    ) {
                        Text("SecondSubjectProc")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("200")
                    }onEditingChanged: { editing in
                        decodeAPI()
                    }
                    
                    //                    Button{
                    //                        decodeAPI()
                    //                    } label: {
                    //                        Text("calculate")
                    //                            .padding(.all, 13.0)
                    //                            .colorMultiply(Color.black)
                    //                    }
                    //                    .overlay(
                    //                        RoundedRectangle(cornerRadius: 16)
                    //                        .stroke(.gray, lineWidth: 1))}
                    
                }}
            
            
            Section(header: Text("Api Resoults")){
                VStack {
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                        .foregroundColor(.accentColor)
                        
                        Text("Api Resoult ").onAppear{
                           decodeAPI()
                        }
                    }
                  
                    VStack(alignment: .leading){
                        Text("ID: \(String(id))")
                        Text("User ID: \(String(userId))")
                        Text("Title:\(titlee)")
                        Text("Status\(String(completed))")
                    }
            
                    
                }
                .padding()
            }
        }
        
    
        
        
    }
    
    
    
    
    func decodeAPI(){
        guard let url = URL(string: url) else{return}

        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()

            if let data = data{
                do{
                    let tasks = try decoder.decode([ToDo].self, from: data)
                    tasks.forEach{ i in
                        //print(i.title)
                        if(i.id == Int(selectedID)){
                            titlee = i.title
                            id = i.id
                            userId = i.userId
                            completed = i.completed
                        }
                    
                    }
                }catch{
                    print(error)
                }
            }
        }
        task.resume()

    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


