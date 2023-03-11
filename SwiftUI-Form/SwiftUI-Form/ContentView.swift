//
//  ContentView.swift
//  SwiftUI-Form
//
//  Created by Shriram Ghadge on 11/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var toggleSwitch: Bool = false
    @State private var numberOfViews: Int = 0
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("Personal Details").bold()) {
                    TextField("First Name", text:  $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                }

                Section("abc"){
                    Toggle("Toggle Switch", isOn: $toggleSwitch).toggleStyle(SwitchToggleStyle(tint: .red))
                    Stepper("Number of Views: \(numberOfViews)", value: $numberOfViews, in: 0...100)
                    Link("Visit Google",destination: URL(string: "https://www.google.com")!)
                }
                
                
                if !firstName.isEmpty && !lastName.isEmpty {
                    Text("Hello, \(firstName.capitalized) \(lastName.capitalized)")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 50)
                    
                }
                
                
            }
            .navigationTitle("SwiftUI Form")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        Button("Save", action: saveAction)
                        Button("Share", action: shareAction)
                        
                    }
                }
            }

           
        }
        .accentColor(.red)

        
    }

    func saveAction() {
        print("Save Action")
    }

    func shareAction() {
        print("Share Action")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
