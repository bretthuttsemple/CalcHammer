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
        @State private var nValue = ""
        @State private var rValue = ""
        @State private var result = ""
        
        var body: some View {
            VStack {
                TextField("Enter N", text: $nValue)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                TextField("Enter R", text: $rValue)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Button("Calculate Permutation") {
                    calculatePermutation()
                }
                .padding()
                
                Text("Result: \(result)")
                    .padding()
                
                Spacer()
            }
            .padding()
                    .navigationTitle("Permutation Calculator")
                    .background(
                        Color.white.opacity(0.0001) // Color makes it so tap gesture works, dismisses keyboard
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    )
        }
        
        private func calculatePermutation() {
            guard let n = Int(nValue),
                  let r = Int(rValue) else {
                result = "Invalid input"
                return
            }
            
            if r > n {
                result = "R should be less than or equal to N"
            } else {
                result = "\(permutation(n: n, r: r))"
            }
        }
        
        private func permutation(n: Int, r: Int) -> Int {
            return factorial(n) / factorial(n - r)
        }
        
        private func factorial(_ n: Int) -> Int {
            if n == 0 {
                return 1
            } else {
                return n * factorial(n - 1)
            }
        }
    }


    struct RandomNumberGeneratorView: View {
        @State private var lowerEnd = "0"
        @State private var upperEnd = "10"
        @State private var randomNumber = ""
        
        var body: some View {
            VStack {
                TextField("Lower end", text: $lowerEnd)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Upper end", text: $upperEnd)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Generate Random Number") {
                    generateRandomNumber()
                }
                .padding()
                
                Text("Random Number: \(randomNumber)")
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Random Number Generator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works, don't question it
                    .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func generateRandomNumber() {
            guard let lower = Int(lowerEnd), let upper = Int(upperEnd) else {
                return
            }
            guard lower <= upper else {
                return // Lower end should be less than or equal to upper end
            }
            
            let random = Int.random(in: lower...upper)
            randomNumber = "\(random)"
        }
    }

    struct CalorieServingSizeCalculatorView: View {
        var body: some View {
            Text("Calorie Serving Size Calculator View")
                .navigationTitle("Calorie Serving Size Calculator")
        }
    }

    struct UnitPriceCalculatorView: View {
        @State private var cost = ""
        @State private var amount = ""
        @State private var unitPrice = ""
        
        var body: some View {
            VStack {
                TextField("Enter cost", text: $cost)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter amount", text: $amount)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Calculate Unit Price") {
                    calculateUnitPrice()
                }
                .padding()
                
                if !unitPrice.isEmpty {
                    Text("Unit price: $\(unitPrice) per unit")
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Unit Price Calculator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works
                    .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculateUnitPrice() {
            guard let costValue = Double(cost), let amountValue = Double(amount), amountValue != 0 else {
                return
            }
            
            let price = costValue / amountValue
            unitPrice = String(format: "%.2f", price)
        }
    }

    struct PizzaAreaCalculatorView: View {
        @State private var pizzaSize = ""
        @State private var pizzaCost = ""
        @State private var selectedShape = "Square"
        @State private var unitCost: Double?
        
        var body: some View {
            VStack {
                TextField("Pizza Size (inches)", text: $pizzaSize)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Pizza Cost ($)", text: $pizzaCost)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Pizza Shape", selection: $selectedShape) {
                    Text("Square").tag("Square")
                    Text("Circular").tag("Circular")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Calculate Unit Cost") {
                    calculateUnitCost()
                }
                .padding()
                
                if let unitCost = unitCost {
                    Text("Cost per Square Inch: $\(String(format: "%.2f", unitCost))")
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Pizza Area Calculator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works
                    .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculateUnitCost() {
            guard let size = Double(pizzaSize),
                  let cost = Double(pizzaCost),
                  size > 0, cost > 0 else {
                unitCost = nil
                return
            }
            
            let area: Double
            if selectedShape == "Circular" {
                area = pow(size / 2, 2) * Double.pi
            } else {
                let width = sqrt(pow(size, 2) / 2)
                let length = width * 2
                area = length * width
            }
            
            unitCost = cost / area
        }
    }

    struct ExactAgeCalculatorView: View {
        @State private var birthDate = Date()
        @State private var exactAge = ""
        
        var body: some View {
            VStack {
                DatePicker("Select birth date", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()
                
                Button("Calculate Exact Age") {
                    calculateExactAge()
                }
                .padding()
                
                if !exactAge.isEmpty {
                    Text("Exact Age: \(exactAge)")
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Exact Age Calculator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works
                    .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculateExactAge() {
            let currentDate = Date()
            let calendar = Calendar.current
            
            let ageComponents = calendar.dateComponents([.year, .month, .day], from: birthDate, to: currentDate)
            
            if let years = ageComponents.year, let months = ageComponents.month, let days = ageComponents.day {
                exactAge = "\(years) years, \(months) months, \(days) days"
            }
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
        @State private var temperature = ""
        @State private var temperatureUnit = "Celsius"
        @State private var speedOfSound = ""
        
        var body: some View {
            VStack {
                TextField("Enter temperature", text: $temperature)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Temperature Unit", selection: $temperatureUnit) {
                    Text("Celsius").tag("Celsius")
                    Text("Fahrenheit").tag("Fahrenheit")
                    Text("Kelvin").tag("Kelvin")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Calculate Speed of Sound") {
                    calculateSpeedOfSound()
                }
                .padding()
                
                if !speedOfSound.isEmpty {
                    Text("Speed of sound: \(speedOfSound) m/s")
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Speed of Sound Calculator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works
                    .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculateSpeedOfSound() {
            guard let temperatureValue = Double(temperature) else {
                return
            }
            
            var convertedTemperature: Double
            
            switch temperatureUnit {
            case "Celsius":
                convertedTemperature = temperatureValue
            case "Fahrenheit":
                convertedTemperature = (temperatureValue - 32) * 5/9
            case "Kelvin":
                convertedTemperature = temperatureValue - 273.15
            default:
                return
            }
            
            // Calculate speed of sound using formula
            let speed = 331.3 * sqrt(1 + (convertedTemperature / 273.15))
            speedOfSound = String(format: "%.2f", speed)
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
