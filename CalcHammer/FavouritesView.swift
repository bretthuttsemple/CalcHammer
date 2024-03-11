//
//  FavouritesView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject private var favouriteItems = FavouriteItems.shared
    //let favouriteCalculators: [String] = Array(FavouriteItems.getFavouriteCalculators())
    
    let views: [String: AnyView] = [
        "Date Difference Calculator": AnyView(CalculatorView.DateDifferenceCalculatorView()),
        "Accumulated Depreciation Calculator": AnyView(CalculatorView.AccumulatedDepreciationView()),
        "Grade Calculator": AnyView(CalculatorView.GradeCalculatorView()),
        "BMI Calculator": AnyView(CalculatorView.BMICalculatorView()),
        "Compound Interest Calculator": AnyView(CalculatorView.CompoundInterestCalculatorView()),
        "Caffeine Half-Life Calculator": AnyView(CalculatorView.CaffeineHalfLifeCalculatorView()),
        "Alcohol Dilution Calculator": AnyView(CalculatorView.AlcoholDilutionCalculatorView()),
        "Permutation Calculator": AnyView(CalculatorView.PermutationCalculatorView()),
        "Random Number Generator": AnyView(CalculatorView.RandomNumberGeneratorView()),
        "Calorie Serving Size Calculator": AnyView(CalculatorView.CalorieServingSizeCalculatorView()),
        "Unit Price Calculator": AnyView(CalculatorView.UnitPriceCalculatorView()),
        "Pizza Area Cost Calculator": AnyView(CalculatorView.PizzaAreaCalculatorView()),
        "Exact Age Calculator": AnyView(CalculatorView.ExactAgeCalculatorView()),
        "Speed of Sound Calculator": AnyView(CalculatorView.SpeedOfSoundCalculatorView()),
        "Percentage Calculator": AnyView(CalculatorView.PercentageCalculatorView()),
        "Fuel Cost Calculator": AnyView(CalculatorView.FuelCostCalculatorView()),
        "Tip Calculator": AnyView(CalculatorView.TipCalculatorView())
    ]
    
    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                        ForEach(favouriteItems.favouriteCalculators.sorted(), id: \.self) { calculator in
                            NavigationLink(destination: views[calculator] ?? AnyView(EmptyView())) {
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
                .navigationTitle("Favourites")
            }
        }
}
