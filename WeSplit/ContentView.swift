//
//  ContentView.swift
//  WeSplit
//
//  Created by Gabriel Afonso on 2/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var tipPercentage = 10
    @State private var numberOfPeople = 2
    @FocusState private var isAmountFocused: Bool
    
    var totalAmount: Double {
        let tipAmount = (checkAmount * (Double(tipPercentage) / 100))
        let total = checkAmount + tipAmount
        
        return total
    }
    
    var totalPerPerson: Double {
        totalAmount / Double(numberOfPeople + 2)
    }
    
    private let tipPercentages = [0, 10, 15, 20, 30]
    private let localeCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter Check Details") {
                    TextField("Check Amount",
                              value: $checkAmount,
                              format: .currency(code: localeCurrency))
                    .keyboardType(.decimalPad)
                    .focused($isAmountFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section("Select Your Tip") {
                    Picker("Select your tip", selection: $tipPercentage) {
                        ForEach(1..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section("Gloabl Total Amount") {
                    Text(totalAmount,
                         format: .currency(code: localeCurrency))
                }
                
                Section("Total per Person") {
                    Text(totalPerPerson,
                         format: .currency(code: localeCurrency))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isAmountFocused {
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
