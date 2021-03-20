//
//  Account.swift
//  ExpensesWallet
//
//  Created by Giovanni Madalozzo on 16/03/21.
//

import Foundation

class Account {
    var type: String
    var bank: String
    var nickname: String
    var historic: [[String]] = []
    
    
    init(type: String, bank: String, nickname: String) {
        self.type = type
        self.bank = bank
        self.nickname = nickname
    }
    
    func report(account:Account) {
        print("\nEXTRATO DA CONTA \(account.nickname.uppercased())")
        if account.historic.isEmpty{
            print("Nenhuma transação registrada")
        }else{
            account.sortHistoric()
            for item in account.historic {
                print("Data da transação: \(item[0]) | Tipo da transação: \(item[1]) | Valor da transação: \(item[2])")
        }
        }
    }
    
    func sortHistoric(){
        self.historic = self.historic.sorted(by: {
             ($0[0]) < ($1[0])
        })
    }
}
