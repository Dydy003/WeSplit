//
//  ContentView.swift
//  WeSplit
//
//  Created by Dylan Caetano on 13/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    // Cette variable suit le montant total de la facture à partager. En utilisant
    
    @State private var numberOfPeople = 2
    // Ici, tu définis combien de personnes vont partager la facture.
    
    @State private var tipPercentage = 20
    // Le pourcentage du pourboire à laisser.
    
    @FocusState private var amountIsFocused: Bool
    // Suivi du focus pour le TextField
    
    let tipPercentages = [10, 15, 20, 25, 0]
    // les pourcentages de pourboire 10, 15, 20, 25. Les options de pourboire classiques. 0 Pour ceux qui ne souhaitent pas laisser de pourboire
    
    var totalPerPerson: Double {
        let peopleCount =  Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
//        Si on suppose :
        
//        checkAmount = 100.0 (100 dollars),
//        tipPercentage = 15 (15 % de pourboire),
//        numberOfPeople = 2 (2 personnes de base),
        
        
//        Alors :

//        Nombre de personnes :
//        peopleCount = 2 + 2 = 4
//        Valeur du pourboire :
//        tipValue = 100 / 100 * 15 = 15
//        Total global :
//        grandTotal = 100 + 15 = 115
//        Montant par personne :
//        amountPerPerson = 115 / 4 = 28.75
//        Chaque personne paiera 28.75 dollars.
    }
    
    var body: some View {
        NavigationStack { // Naviguer
            
            Form {
                // Formulaire
                
                Section { // Section comme une cellule
                    
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    // TextField :Type de vue SwiftUI utilisé pour capturer des entrées textuelles de l'utilisateur.Ici, il est utilisé pour demander à l'utilisateur de saisir un montant.
                    
                    // "Amount" : C'est le texte indicatif qui apparaît dans le champ avant qu'une valeur ne soit saisie. C'est une sorte de placeholder pour guider l'utilisateur. Exemple : "Entrez un montant".
                    // value: $checkAmount : $checkAmount est une liaison (binding) à la variable checkAmount (un @State ou une variable observable ailleurs). Chaque fois que l'utilisateur modifie la valeur du champ, checkAmount est automatiquement mis à jour.
                    
                    // format: .currency(code: ...) : .currency est un format prédéfini dans SwiftUI pour afficher les valeurs numériques en tant que devise.
                    
                    // code: Locale.current.currency?.identifier ?? "EUR" : Locale.current.currency : Identifie la devise locale de l'utilisateur (par ex., USD pour les États-Unis ou EUR pour  l'Europe). ?.identifier : Extrait l'identifiant de la devise, comme "USD" ou "EUR". ?? "EUR" : Si la devise locale n'est pas disponible (très rare), on utilise l'euro par défaut.
                    //
                        .keyboardType(.decimalPad) // Active le clavier numerique
                        .focused($amountIsFocused) // Associe le focus à `amountIsFocused`
                    
                    Picker("Nombre de personne", selection: $numberOfPeople) { // Prend plusieur tache
                        
                        ForEach(2..<100) { // ForEach: Si tu as un tableau de données et que tu veux générer une série de vues correspondant à chaque élément. ou Tu peux utiliser ForEach dans des colonnes, des lignes ou des grilles.
                            
                            Text("\($0) personne")
                        }
                    }
                    .pickerStyle(.navigationLink) // Le style du picker
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave ?")
                    // Quel est le montant du pourboire que vous souhaitez laisser ?
                }
                    
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
            }
            .navigationTitle("WeSplit") // Le titre
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false // Retire le focus quand l'utilisateur appuie sur le bouton
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
