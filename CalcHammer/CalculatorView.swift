import SwiftUI



struct CalculatorView: View {
    let calculators = [
        "Date Difference Calculator",
        "Accumulated Depreciation Calculator",
        "Accumulated Apreciation Calculator",
        "Grade Calculator",
        "BMI Calculator",
        "Compound Interest Calculator",
        "Caffeine Half-Life Calculator",
        "Liquid Dilution Calculator",
        "Permutation Calculator",
        "Random Number Generator",
        "Calorie Serving Size Calculator",
        "Unit Price Calculator",
        "Pizza Area Cost Calculator",
        "Exact Age Calculator",
        "Speed of Sound Calculator",
        "Percantage Calculator",
        "Fuel Cost Calculator"
    ]
    
    @State private var selectedCalculator: Int?
        
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                    ForEach(calculators.indices, id: \.self) { index in
                        Button(action: {
                            selectedCalculator = index
                        }) {
                            Text(calculators[index])
                                .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 175, height: 150)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .multilineTextAlignment(.center)
                                                }
                                    .alignmentGuide(.leading) { _ in CGFloat(-10) }
                                    .onTapGesture {
                                        selectedCalculator = index                            }
                            }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Calculators")
            .background(
                NavigationLink(
                            destination: destinationView(),
                            tag: selectedCalculator ?? -1, // Use a default value if selectedCalculator is nil
                            selection: $selectedCalculator,
                            label: {
                                EmptyView()
                            }
                        )
                .isDetailLink(false) // Add this to prevent duplicate navigation bars
            )
        }
    }
    
    @ViewBuilder
    func destinationView() -> some View {
        if let index = selectedCalculator {
            switch index {
            case 0:
                DateDifferenceCalculatorView()
            case 1:
                AccumulatedDepreciationView()
            case 2:
                AccumulatedAppreciationCalculatorView()
            case 3:
                GradeCalculatorView()
            case 4:
                BMICalculatorView()
            case 5:
                CompoundInterestCalculatorView()
            case 6:
                CaffeineHalfLifeCalculatorView()
            case 7:
                LiquidDilutionCalculatorView()
            case 8:
                PermutationCalculatorView()
            case 9:
                RandomNumberGeneratorView()
            case 10:
                CalorieServingSizeCalculatorView()
            case 11:
                UnitPriceCalculatorView()
            case 12:
                PizzaAreaCalculatorView()
            case 13:
                ExactAgeCalculatorView()
            case 14:
                SpeedOfSoundCalculatorView()
            case 15:
                PercantageCalculator()
            case 16:
                FuelCostCalculator()
            default:
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
    
    struct AccumulatedAppreciationCalculatorView: View {
        var body: some View {
            Text("Accumulated Appreciation Calculator View")
                .navigationTitle("Accumulated Appreciation Calculator")
        }
    }

    //edit this later :)
    struct BMICalculatorView: View {
        @State private var weight = ""
        @State private var height = ""
        @State private var isMetric = true // Toggle for metric/imperial system
        @State private var bmi = "" // Output BMI value

        var body: some View {
            VStack {
                Toggle(isOn: $isMetric) {
                    Text("Metric")
                }
                .padding()
                
                TextField(isMetric ? "Enter weight (kg)" : "Enter weight (lbs)", text: $weight)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField(isMetric ? "Enter height (m)" : "Enter height (in)", text: $height)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Calculate BMI") {
                    calculateBMI()
                }
                .padding()

                Text("BMI: \(bmi)")
                    .padding()
                
                Spacer()
            }
            .padding()
                    .navigationTitle("BMI Calculator")
                    .background(
                        Color.white.opacity(0.0001) // Color makes it so tap gesture works, don't question it
                            .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    )
            
        }
        

        private func calculateBMI() {
            guard let weight = Double(weight),
                  let height = Double(height),
                  height != 0 else {
                return
            }
            
            let bmiValue: Double
            if isMetric {
                bmiValue = weight / (height * height)
            } else {
                bmiValue = (weight / (height * height)) * 703 // Conversion for imperial system
            }
            
            bmi = String(format: "%.2f", bmiValue)
        }
    }
    
    struct CompoundInterestCalculatorView: View {
        var body: some View {
            Text("Compound Interest Calculator View")
                .navigationTitle("Compound Interest Calculator")
        }
    }

    struct CaffeineHalfLifeCalculatorView: View {
        var body: some View {
            Text("Caffeine Half-Life Calculator View")
                .navigationTitle("Caffeine Half-Life Calculator")
        }
    }

    struct LiquidDilutionCalculatorView: View {
        var body: some View {
            Text("Liquid Dilution Calculator View")
                .navigationTitle("Liquid Dilution Calculator")
        }
    }

    struct PermutationCalculatorView: View {
        var body: some View {
            Text("Permutation Calculator View")
                .navigationTitle("Permutation Calculator")
        }
    }

    struct RandomNumberGeneratorView: View {
        var body: some View {
            Text("Random Number Generator View")
                .navigationTitle("Random Number Generator")
        }
    }

    struct CalorieServingSizeCalculatorView: View {
        var body: some View {
            Text("Calorie Serving Size Calculator View")
                .navigationTitle("Calorie Serving Size Calculator")
        }
    }

    struct UnitPriceCalculatorView: View {
        var body: some View {
            Text("Unit Price Calculator View")
                .navigationTitle("Unit Price Calculator")
        }
    }

    struct PizzaAreaCalculatorView: View {
        var body: some View {
            Text("Pizza Area Calculator View")
                .navigationTitle("Pizza Area Calculator")
        }
    }

    struct ExactAgeCalculatorView: View {
        var body: some View {
            Text("Exact Age Calculator View")
                .navigationTitle("Exact Age Calculator")
        }
    }
    struct DateDifferenceCalculatorView: View {
        var body: some View {
            Text("Date Difference Calculator View")
                .navigationTitle("Date Difference Calculator")
        }
    }

    struct AccumulatedDepreciationView: View {
        var body: some View {
            Text("Accumulated Depreciation View")
                .navigationTitle("Accumulated Depreciation")
        }
    }

    struct GradeCalculatorView: View {
        var body: some View {
            Text("Grade Calculator View")
                .navigationTitle("Grade Calculator")
        }
    }

    struct SpeedOfSoundCalculatorView: View {
        var body: some View {
            Text("Speed of Sound Calculator View")
                .navigationTitle("Speed of Sound Calculator")
        }
    }
    
    struct PercantageCalculator: View {
        var body: some View {
            Text("Percantage Calculator View")
                .navigationTitle("Percantage Calculator")
        }
    }
    
    struct FuelCostCalculator: View {
        var body: some View {
            Text("Fuel cost calcualtor view")
                .navigationTitle("Fuel Cost Calculator")
        }
    }
}
