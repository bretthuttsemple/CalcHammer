import SwiftUI
import SwiftData

protocol Calculators {
    func addHistoryItem(historyText: String, context: ModelContext)
}

extension Calculators {
    func saveToHistory(historyText: String, context: ModelContext) {
        let item = HistoryItem(historyText: historyText)
        context.insert(item)
    }
}

struct CalculatorView: View {
    @State private var searchText = ""
    @State private var selectedCalculator: String?
    
    let calculators: [String] = [
        "Date Difference Calculator",
        "Accumulated Depreciation Calculator",
        "Accumulated Appreciation Calculator",
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
        "Percentage Calculator",
        "Fuel Cost Calculator"
    ].sorted()
    
    let views: [String: AnyView] = [
        "Date Difference Calculator": AnyView(DateDifferenceCalculatorView()),
        "Accumulated Depreciation Calculator": AnyView(AccumulatedDepreciationView()),
        "Grade Calculator": AnyView(GradeCalculatorView()),
        "BMI Calculator": AnyView(BMICalculatorView()),
        "Compound Interest Calculator": AnyView(CompoundInterestCalculatorView()),
        "Caffeine Half-Life Calculator": AnyView(CaffeineHalfLifeCalculatorView()),
        "Liquid Dilution Calculator": AnyView(LiquidDilutionCalculatorView()),
        "Permutation Calculator": AnyView(PermutationCalculatorView()),
        "Random Number Generator": AnyView(RandomNumberGeneratorView()),
        "Calorie Serving Size Calculator": AnyView(CalorieServingSizeCalculatorView()),
        "Unit Price Calculator": AnyView(UnitPriceCalculatorView()),
        "Pizza Area Cost Calculator": AnyView(PizzaAreaCalculatorView()),
        "Exact Age Calculator": AnyView(ExactAgeCalculatorView()),
        "Speed of Sound Calculator": AnyView(SpeedOfSoundCalculatorView()),
        "Percentage Calculator": AnyView(PercentageCalculatorView()),
        "Fuel Cost Calculator": AnyView(FuelCostCalculatorView())
    ]
    
    var filteredCalculators: [String] {
        if searchText.isEmpty {
            return calculators
        } else {
            return calculators.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                        ForEach(filteredCalculators, id: \.self) { calculator in
                            Button(action: {
                                selectedCalculator = calculator
                            }) {
                                Text(calculator)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 175, height: 150)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .navigationTitle("Calculators")
                .background(
                    NavigationLink(
                        destination: views[selectedCalculator ?? ""] ?? AnyView(EmptyView()),
                        isActive: Binding<Bool>(
                            get: { selectedCalculator != nil },
                            set: { if !$0 { selectedCalculator = nil } }
                        ),
                        label: { EmptyView() }
                    )
                    .isDetailLink(false) // Add this to prevent duplicate navigation bars
                )
            }
        }
    }
    
    struct BMICalculatorView: View, Calculators{
        @State private var weight = ""
        @State private var height = ""
        @State private var isMetric = true // Toggle for metric/imperial system
        @State private var bmi = "" // Output BMI value
        @State private var isInfoPopoverVisible = false

        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }

        var body: some View {
            VStack {
                HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("BMI (Body Mass Index)")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("BMI measures body fat based on height and weight, providing insight into health risks associated with weight categories. For more information, visit Health Canada's website.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
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
                bmi = String(format: "%.2f", bmiValue)
                addHistoryItem(historyText: "The BMI is \(bmi), calculated from weight \(weight) kg and height \(height) m.", context: context)
            } else {
                bmiValue = (weight / (height * height)) * 703 // Conversion for imperial system
                bmi = String(format: "%.2f", bmiValue)
                addHistoryItem(historyText: "The BMI is \(bmi), calculated from weight \(weight) lbs and height \(height) inches.", context: context)
            }
        }
    }
    
    struct CompoundInterestCalculatorView: View,Calculators{
        @State private var principal = ""
        @State private var interestRate = ""
        @State private var time = ""
        @State private var compoundFrequency = "Annually"
        @State private var result = ""
        
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }

        let compoundFrequencies = ["Annually", "Semi-Annually", "Quarterly", "Monthly"]

        var body: some View {
            HStack{
                Spacer()
                Button(action: {
                                isInfoPopoverVisible.toggle()
                            }) {
                                Image(systemName: "info.circle")
                                    .padding()
                            }
                            .popover(isPresented: $isInfoPopoverVisible){
                                VStack {
                                    Text("Compound Interest")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Text("The Compound Interest Calculator computes the accrued interest on an investment based on principal amount, interest rate, time, and compound frequency. Varying compound frequencies, such as semi-annually or monthly, impact how often interest is added to the principal, affecting overall returns.")
                                        .padding()
                                        .presentationCompactAdaptation(.popover)

                                }
                                .frame(width: 300, height: 200) // Set preferred size for the popover
                            }
            }
            VStack {
                TextField("Principal", text: $principal)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                TextField("Interest Rate (%)", text: $interestRate)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                TextField("Time (years)", text: $time)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                Picker("Compound Frequency", selection: $compoundFrequency) {
                    ForEach(compoundFrequencies, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Button("Calculate") {
                    calculateCompoundInterest()
                }
                .padding()

                if !result.isEmpty {
                    Text("Compound Interest: \(result)")
                        .padding()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Compound Interest Calculator")
            .background(
                Color.white.opacity(0.0001)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }

        private func calculateCompoundInterest() {
            guard let principalValue = Double(principal),
                  let interestRateValue = Double(interestRate),
                  let timeValue = Double(time) else {
                result = "Invalid input"
                return
            }

            let n: Double
            switch compoundFrequency {
            case "Semi-Annually":
                n = 2
            case "Quarterly":
                n = 4
            case "Monthly":
                n = 12
            default:
                n = 1
            }

            let compoundInterest = principalValue * pow(1 + interestRateValue / (100 * n), n * timeValue) - principalValue
            result = String(format: "%.2f", compoundInterest)
            addHistoryItem(historyText: "Principal: \(principal), Interest Rate: \(interestRate)%, Time: \(time) years, Compound Frequency: \(compoundFrequency), Result: \(result)", context: context)
        }
    }

    struct CaffeineHalfLifeCalculatorView: View,Calculators{
        @State private var initialAmount = ""
        @State private var timePassed = ""
        @State private var halfLife = "5.7" // Default half-life of caffeine in hours
        @State private var result = ""
        
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Caffeine Half-Life")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("Caffeine half-life is the duration for the body to clear half of ingested caffeine, reducing its amount in the system. Varied half-lives among sources impact caffeine metabolism and its stimulating effects.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 300) // Set preferred size for the popover
                                }
                }
            VStack {
                TextField("Initial Amount (mg)", text: $initialAmount)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                TextField("Time Passed (hours)", text: $timePassed)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)

                HStack {
                    Text("Half-Life (hours):")
                    TextField("Half-Life", text: $halfLife)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }

                Button("Calculate") {
                    calculateCaffeineHalfLife()
                }
                .padding()

                if !result.isEmpty {
                    Text("Remaining Caffeine: \(result) mg")
                        .padding()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Caffeine Half-Life Calculator")
            .background(
                Color.white.opacity(0.0001)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }

        private func calculateCaffeineHalfLife() {
            guard let initialAmountValue = Double(initialAmount),
                  let timePassedValue = Double(timePassed),
                  let halfLifeValue = Double(halfLife) else {
                result = "Invalid input"
                return
            }

            let remainingCaffeine = initialAmountValue * pow(0.5, timePassedValue / halfLifeValue)
            result = String(format: "%.2f", remainingCaffeine)
            addHistoryItem(historyText: "There is \(remainingCaffeine) mg of caffiene left from the \(initialAmountValue) mg of caffiene consumed \(timePassedValue) hours ago", context: context)
        }
    }

    struct LiquidDilutionCalculatorView: View {
        var body: some View {
            Text("Liquid Dilution Calculator View")
                .navigationTitle("Liquid Dilution Calculator")
        }
    }

    struct PermutationCalculatorView: View, Calculators{
        @State private var nValue = ""
        @State private var rValue = ""
        @State private var result = ""
        
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Permutation Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("A permutation calculator computes the number of ways to arrange a subset of items from a larger set, considering the order of arrangement. Inputs typically include two numbers: N (representing the total number of items) and R (representing the number of items to be arranged). The output provides the total number of permutations possible for arranging R items from a set of N items.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
            
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
                addHistoryItem(historyText: "Permuation: N = \(n), R = \(r), Result = \(result)", context: context)
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

    struct RandomNumberGeneratorView: View,Calculators{
        @State private var lowerEnd = "0"
        @State private var upperEnd = "10"
        @State private var randomNumber = ""
        @State private var isInfoPopoverVisible = false

        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Random Number Generator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The random number generator allows users to generate a random integer within a specified range defined by the upper and lower limits.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
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
            addHistoryItem(historyText: "Upper Limit = \(lower), Upper Limit = \(upper), Random Value = \(randomNumber)", context: context)
        }
    }

    struct CalorieServingSizeCalculatorView: View, Calculators{
        @State private var caloriesPerServing = ""
        @State private var boxServingSize = ""
        @State private var actualServingSize = ""
        @State private var caloriesInActualServing = ""
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Calorie Serving Size")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The calorie serving size calculator calculates the calorie content for a specified serving size based on the calorie count and serving size from a nutritional label, along with the actual serving size intended for consumption.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
            VStack {
                TextField("Calories per serving", text: $caloriesPerServing)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Serving size on Label", text: $boxServingSize)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Actual serving size", text: $actualServingSize)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                Button("Calculate Calories in Actual Serving") {
                    calculateCaloriesInActualServing()
                }
                .padding()
                
                if !caloriesInActualServing.isEmpty {
                    Text("Calories in actual serving: \(caloriesInActualServing)")
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Calorie Serving Size Calculator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works
                    .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculateCaloriesInActualServing() {
            guard let caloriesPerServingValue = Double(caloriesPerServing),
                  let boxServingSizeValue = Double(boxServingSize),
                  let actualServingSizeValue = Double(actualServingSize),
                  boxServingSizeValue != 0 else {
                return
            }
            
            let caloriesInActualServingValue = (caloriesPerServingValue / boxServingSizeValue) * actualServingSizeValue
            caloriesInActualServing = String(format: "%.2f", caloriesInActualServingValue)
            addHistoryItem(historyText: "\(caloriesPerServingValue) calories per \(boxServingSizeValue) units = \(caloriesInActualServingValue) calories per \(actualServingSizeValue) units", context: context)
        }
    }

    struct UnitPriceCalculatorView: View,Calculators{
        @State private var cost = ""
        @State private var amount = ""
        @State private var unitPrice = ""
        @State private var isInfoPopoverVisible = false

        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Unit Price Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The unit price calculator helps compare prices of similar items that come in different quantities, aiding in making cost-effective purchasing decisions.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
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
            addHistoryItem(historyText: "\(amountValue) items costing \(costValue) each for a total of \(unitPrice)", context: context)
        }
    }

    struct PizzaAreaCalculatorView: View,Calculators{
        @State private var pizzaSize = ""
        @State private var pizzaCost = ""
        @State private var selectedShape = "Square"
        @State private var unitCost: Double?
        @State private var isInfoPopoverVisible = false

        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Pizza Area Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The pizza area calculator assists in comparing the prices of pizzas of different sizes, whether circular or rectangular, enabling informed decisions on cost-effective purchases.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
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
            addHistoryItem(historyText: "Cost per Square Inch:\(String(describing: unitCost))", context: context)
        }
    }

    struct ExactAgeCalculatorView: View,Calculators{
        @State private var birthDate = Date()
        @State private var exactAge = ""
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Exact Age Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The exact age calculator determines your precise age in years, months, and days, providing accurate information for various purposes.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
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
                addHistoryItem(historyText:"An exact age was calcualted for \(years) years, \(months) months, \(days) days", context: context)
            }
        }
    }
    
    struct DateDifferenceCalculatorView: View,Calculators {
        @State private var startDate = Date()
        @State private var endDate = Date()
        @State private var dateDifference = ""
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Date Difference Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The date difference calculator calculates the precise duration between two dates, allowing you to determine the exact number of days, months, and years elapsed between them.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
            VStack {
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding(.horizontal)
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding(.horizontal)
                
                Button("Calculate Date Difference") {
                    calculateDateDifference()
                }
                .padding()
                
                if !dateDifference.isEmpty {
                    Text("Date Difference: \(dateDifference)")
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Date Difference Calculator")
        }
        
        private func calculateDateDifference() {
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day], from: startDate, to: endDate)
            
            if let years = components.year, let months = components.month, let days = components.day {
                dateDifference = "\(years) years, \(months) months, \(days) days"
                addHistoryItem(historyText: "\(components) was \(dateDifference) ago", context: context)
            }
        }
    }

    struct AccumulatedDepreciationView: View,Calculators {
        @State private var initialCost = ""
        @State private var depreciationRate = ""
        @State private var years = ""
        @State private var updatedCost = ""
        
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
                func addHistoryItem(historyText: String, context: ModelContext) {
                    saveToHistory(historyText: historyText, context: context)
                }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Accumulated Depreciation")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The accumulated depreciation calculator computes the total depreciation of an asset over its useful life, taking into account factors such as initial cost, salvage value, and depreciation method. It provides the accumulated depreciation amount, which represents the total reduction in the asset's value over time.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
            VStack {
                TextField("Initial Cost", text: $initialCost)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Depreciation Rate (%)", text: $depreciationRate)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Number of Years", text: $years)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Button("Calculate") {
                    calculateDepreciation()
                }
                .padding()
                
                Text("Updated Cost: $\(updatedCost)")
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Accumulated Depreciation Calculator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works
                    .onTapGesture { // Dismisses keyboard when user taps anywhere outside text field
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculateDepreciation() {
            guard let initialCostValue = Double(initialCost),
                  let depreciationRateValue = Double(depreciationRate),
                  let yearsValue = Int(years) else {
                return
            }
            
            var updatedCostValue = initialCostValue
            for _ in 1...yearsValue {
                updatedCostValue -= updatedCostValue * depreciationRateValue / 100
            }
            
            // Ensure cost doesn't go below zero
            updatedCostValue = max(updatedCostValue, 0)
            
            updatedCost = String(format: "%.2f", updatedCostValue)
            addHistoryItem(historyText: "With an intial value of \(initialCostValue), a depreciation rate of \(depreciationRateValue), and \(yearsValue) years, the value will be \(updatedCostValue)", context: context)
        }
    }

    struct GradeCalculatorView: View,Calculators {
        @State private var currentGrade = 0.0
        @State private var examWeight = 0.0
        @State private var desiredGrade = 0.0
        @State private var isCalculateNeededGrade = true
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
        func addHistoryItem(historyText: String, context: ModelContext) {
            saveToHistory(historyText: historyText, context: context)
        }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Grade Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The grade calculator has two modes: one predicts the final exam score needed to achieve a desired grade, and the other computes the achieved grade based on the final exam result. It requires the current grade, exam weight, and either the target grade or final exam score.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
            VStack {
                // Current Grade
                HStack {
                    Text("Current Grade (%)")
                    Spacer()
                    TextField("", value: $currentGrade, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
                
                // Exam Weight
                HStack {
                    Text("Exam Weight (%)")
                    Spacer()
                    TextField("", value: $examWeight, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
                
                // Desired Grade or Final Exam Grade
                HStack {
                    Text(isCalculateNeededGrade ? "Desired Grade (%)" : "Final Exam Grade (%)")
                    Spacer()
                    TextField("", value: $desiredGrade, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
                
                // Toggle for switching between calculating needed grade or final grade
                Toggle("Calculate Needed Grade", isOn: $isCalculateNeededGrade)
                    .padding()
                
                // Button to trigger calculation
                Button("Calculate") {
                    calculateGrade()
                }
                .padding()
                
                // Result text
                Text(resultText())
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Grade Calculator")
            .onTapGesture {
                // Dismiss keyboard when tapping outside of text fields
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
        // Function to calculate the grade
        private func calculateGrade() {
            if isCalculateNeededGrade {
                let neededGrade = (desiredGrade - (1 - examWeight / 100) * currentGrade) / (examWeight / 100)
                showResult(neededGrade: neededGrade)
            } else {
                let finalGrade = currentGrade * (1 - examWeight / 100) + examWeight / 100 * desiredGrade
                showResult(finalGrade: finalGrade)
            }
        }
        
        // Function to display the result
        private func showResult(neededGrade: Double? = nil, finalGrade: Double? = nil) {
            if let neededGrade = neededGrade {
                // Show the needed grade result
                print("To achieve \(desiredGrade)% overall, you need to score \(neededGrade)% on the final exam.")
                addHistoryItem(historyText: "To achieve \(desiredGrade)% overall, you need to score \(neededGrade)% on the final exam.", context: context)
            } else if let finalGrade = finalGrade {
                // Show the final grade result
                print("If you score \(desiredGrade)% on the final exam, your overall grade will be \(finalGrade)%.")
                addHistoryItem(historyText: "If you score \(desiredGrade)% on the final exam, your overall grade will be \(finalGrade)%.", context: context)
            }
        }
        
        // Function to format the result text
        private func resultText() -> String {
            if isCalculateNeededGrade {
                return "To achieve \(desiredGrade)% overall, you need to score \(neededGrade())% on the final exam."
            } else {
                return "If you score \(desiredGrade)% on the final exam, your overall grade will be \(finalGrade())%."
            }
        }
        
        // Function to calculate the needed grade
        private func neededGrade() -> Double {
            return (desiredGrade - (1 - examWeight / 100) * currentGrade) / (examWeight / 100)
        }
        
        // Function to calculate the final grade
        private func finalGrade() -> Double {
            return currentGrade * (1 - examWeight / 100) + examWeight / 100 * desiredGrade
        }
    }

    struct SpeedOfSoundCalculatorView: View,Calculators {
        @State private var temperature = ""
        @State private var temperatureUnit = "Celsius"
        @State private var speedOfSound = ""
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
        func addHistoryItem(historyText: String, context: ModelContext) {
            saveToHistory(historyText: historyText, context: context)
        }
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Speed of Sound Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The speed of sound calculator determines the speed of sound in air, which varies with temperature. It's important to note that this calculator specifically applies to sound waves traveling through air, as the speed of sound differs in other substances. Temperature affects the speed of sound because air particles move faster at higher temperatures, allowing sound waves to propagate more quickly through the medium.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                        }
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
                let speed = 331.3 * sqrt(1 + (convertedTemperature / 273.15))
                speedOfSound = String(format: "%.2f", speed)
                addHistoryItem(historyText: "When the tempature is \(convertedTemperature) °C the speed of sound is \(speed) m/s", context: context)
            case "Fahrenheit":
                convertedTemperature = (temperatureValue - 32) * 5/9
                let speed = 331.3 * sqrt(1 + (convertedTemperature / 273.15))
                speedOfSound = String(format: "%.2f", speed)
                addHistoryItem(historyText: "When the tempature is \(temperatureValue) °F the speed of sound is \(speed) m/s", context: context)
            case "Kelvin":
                convertedTemperature = temperatureValue - 273.15
                let speed = 331.3 * sqrt(1 + (convertedTemperature / 273.15))
                speedOfSound = String(format: "%.2f", speed)
                addHistoryItem(historyText: "When the tempature is \(temperatureValue) °K the speed of sound is \(speed) m/s", context: context)
            default:
                return
            }
        }
    }
    
    struct PercentageCalculatorView: View, Calculators {
        @State private var originalValue = ""
        @State private var percentage = ""
        @State private var result = ""
        @Environment(\.modelContext) private var context
        @State private var isInfoPopoverVisible = false
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Percentage Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The percentage calculator computes the result of a percentage value based on an original number.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
            VStack {
                TextField("Original Value", text: $originalValue)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                TextField("Percentage", text: $percentage)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Button("Calculate") {
                    calculatePercentage()
                }
                .padding()
                
                Text("Result: \(result)")
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Percentage Calculator")
            .background(
                Color.white.opacity(0.0001)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculatePercentage() {
            guard let originalValue = Double(originalValue),
                  let percentage = Double(percentage) else {
                result = "Invalid input"
                return
            }
            
            let percentageValue = originalValue * percentage / 100
            result = "\(percentageValue)"
            
            addHistoryItem(historyText: "\(percentage)% of \(originalValue) = \(result)", context: context)
        }
        
        func addHistoryItem(historyText: String, context: ModelContext) {
            saveToHistory(historyText: historyText, context: context)
        }
    }
    
    struct FuelCostCalculatorView: View, Calculators {
        func addHistoryItem(historyText: String, context: ModelContext) {
            saveToHistory(historyText: historyText, context: context)
        }
        
        @State private var tripDistance = ""
        @State private var fuelEfficiency = ""
        @State private var fuelPrice = ""
        @State private var result = ""
        @State private var isInfoPopoverVisible = false
        
        @Environment(\.modelContext) private var context
        
        var body: some View {
            HStack{
                    Spacer()
                    Button(action: {
                                    isInfoPopoverVisible.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .padding()
                                }
                                .popover(isPresented: $isInfoPopoverVisible){
                                    VStack {
                                        Text("Fuel Cost Calculator")
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        Text("The fuel cost calculator computes the total cost of fuel for a given trip based on the trip distance, fuel efficiency, and fuel price per liter. It provides the total fuel needed for the trip and the corresponding cost, making it useful for planning road trips.")
                                            .padding()
                                            .presentationCompactAdaptation(.popover)

                                    }
                                    .frame(width: 300, height: 200) // Set preferred size for the popover
                                }
                }
            VStack {
                TextField("Trip Distance (km)", text: $tripDistance)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Fuel Efficiency (km/l)", text: $fuelEfficiency)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Fuel Price per Liter", text: $fuelPrice)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                Button("Calculate") {
                    calculateFuelCost()
                }
                .padding()
                
                Text("Result: \(result)")
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Fuel Cost Calculator")
            .background(
                Color.white.opacity(0.0001) // Color makes it so tap gesture works, dismisses keyboard
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        
        private func calculateFuelCost() {
            guard let tripDistance = Double(tripDistance),
                  let fuelEfficiency = Double(fuelEfficiency),
                  let fuelPrice = Double(fuelPrice) else {
                result = "Invalid input"
                return
            }
            
            let fuelNeeded = tripDistance / fuelEfficiency
            let cost = fuelNeeded * fuelPrice
            
            result = "Fuel needed: \(String(format: "%.2f", fuelNeeded)) liters, Cost: $\(String(format: "%.2f", cost))"
            addHistoryItem(historyText: "A \(tripDistance) km trip will cost \(cost)", context: context)

        }
    }
}
