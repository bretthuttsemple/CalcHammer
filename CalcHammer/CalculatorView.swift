import SwiftUI



struct CalculatorView: View {
    let calculators = [
        "Date Difference Calculator",
        "Accumulated Depreciation",
        "Accumulated Apreciation Calculator",
        "Grade Calculator",
        "Mean Average Calculator",
        "BMI Calculator",
        "Compound Interest Calculator",
        "Caffeine Half-Life Calculator",
        "Liquid Dilution Calculator",
        "Permutation Calculator",
        "Random Number Generator",
        "Calorie Serving Size Calculator",
        "Unit Price Calculator",
        "Pizza Area Calculator",
        "Exact Age Calculator",
        "Speed of Sound Calculator"
    ]
    
    @State private var selectedCalculator: Int?
        
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                    ForEach(calculators.indices, id: \.self) { index in
                        Text(calculators[index])
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
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
                MeanAverageCalculatorView()
            case 5:
                BMICalculatorView()
            case 6:
                CompoundInterestCalculatorView()
            case 7:
                CaffeineHalfLifeCalculatorView()
            case 8:
                LiquidDilutionCalculatorView()
            case 9:
                PermutationCalculatorView()
            case 10:
                RandomNumberGeneratorView()
            case 11:
                CalorieServingSizeCalculatorView()
            case 12:
                UnitPriceCalculatorView()
            case 13:
                PizzaAreaCalculatorView()
            case 14:
                ExactAgeCalculatorView()
            case 15:
                SpeedOfSoundCalculatorView()
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

    struct MeanAverageCalculatorView: View {
        var body: some View {
            Text("Mean Average Calculator View")
                .navigationTitle("Mean Average Calculator")
        }
    }

    struct BMICalculatorView: View {
        var body: some View {
            Text("BMI Calculator View")
                .navigationTitle("BMI Calculator")
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
}
