//
//  Purchases.swift
//  ExpensesWallet
//
//  Created by Giovanni Madalozzo on 16/03/21.
//

import Foundation

class Purchases: RegisterData {
    
    func single() {
        
    }
    
    func recurrent() -> String{
        print("Digite o valor da cobrança recorrente: ")
        let value = readLine()
        
        guard let unwrappedValue = value else {
            return ""
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        guard let valueDouble = Double(unwrappedValue) else{
            return "Nenhum valor digitado. Retornando para o menu."
        }
        let valueNS = NSNumber(value: valueDouble)
        guard let unwrappedValue2 = numberFormatter.string(from: valueNS) else{
            return ""
        }
        print("\nValor da cobrança recorrente: \(unwrappedValue2)")
        
        
        print("\nDigite o dia em que a cobrança será realizada: ")
        let date = readLine()
        
        guard let unwrappedDate = date else {
            return "Nenhuma data digitada. Retornando para o menu."
        }
        
        if unwrappedDate == "" {
            return "Nenhuma data digitada. Retornando para o menu."
        }
        
        print("\nDia da cobrança periódica: \(unwrappedDate)")
        
        return "\nRegistro realizado com sucesso! Retornando para o menu.\n\n"
    }
}
