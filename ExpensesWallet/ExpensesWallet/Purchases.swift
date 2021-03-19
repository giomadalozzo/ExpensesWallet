//
//  Purchases.swift
//  ExpensesWallet
//
//  Created by Giovanni Madalozzo on 16/03/21.
//

import Foundation

class Purchases: RegisterData {
    
    func add(account: Account) -> String{
        print("Digite o valor da cobrança: ")
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
        print("\nValor da cobrança: \(unwrappedValue2)")
        
        
        print("\nDigite o dia em que a cobrança foi ou será realizada: ")
        let date = readLine()
        
        guard let unwrappedDate = date else {
            return "Nenhuma data digitada. Retornando para o menu."
        }
        
        if unwrappedDate == "" {
            return "Nenhuma data digitada. Retornando para o menu."
        }
        
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LL"
        let dateMonth = Int(dateFormatter.string(from: now))
        dateFormatter.dateFormat = "YYYY"
        let dateYear = Int(dateFormatter.string(from: now))
        
        
        var comp = DateComponents(calendar: .current, year: dateYear, month: dateMonth, day: Int(unwrappedDate))

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let dateString = "\(dateFormatter.string(from: comp.date!))"
        print("\nData da cobrança: \(dateString)")
        var transaction: [String] = [dateString, "Débito", unwrappedValue2]
        
        account.historic.append(transaction)
        
        print(transaction)
        
        return "\nRegistro realizado com sucesso! Retornando para o menu.\n\n"
    }
}
