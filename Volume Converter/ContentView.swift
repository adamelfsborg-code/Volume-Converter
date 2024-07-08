import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0.0
    @State private var inputUnit: String = "Liter"
    @State private var outputUnit: String = "Milliliters"
    @FocusState private var isFocused: Bool
    
    let volumeUnits: [String: Double] = ["Liter": 1.0, "Milliliters": 1000.0, "Gallons": 3.78]
    
    
    var outputValue: Double {
        let inputInLiters = inputValue / (volumeUnits[inputUnit] ?? 1.0)
        return inputInLiters * (volumeUnits[outputUnit] ?? 1.0)
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input unit") {
                    Picker("Pick input unit", selection: $inputUnit) {
                        ForEach(volumeUnits.keys.sorted(), id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Input value") {
                    TextField("Volume to convert", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                
                Section("Output unit") {
                    Picker("Pick output unit", selection: $outputUnit) {
                        ForEach(volumeUnits.keys.sorted(), id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Output value") {
                    Text("\(outputValue.formatted())")
                }
                
            }
            .navigationTitle("Volume Converter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
