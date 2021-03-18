//
//  Account.swift
//  ExpensesWallet
//
//  Created by Giovanni Madalozzo on 16/03/21.
//

import Foundation

class Account {
    let type: String
    let bank: String
    let nickname: String
    var historic: [[String]] = []
    
    
    // R$ 113.32  -> String R$ 113.32 [[String]]   [ [débito, 11/02, R$ 113.32] ]
    
    init(type: String, bank: String, nickname: String) {
        self.type = type
        self.bank = bank
        self.nickname = nickname
    }
    
    func report(account:Account) {
        for item in account.historic {
            print("Tipo de transação: \(item[0]) Data da transação: \(item[1]) Valor da transação: \(item[2])")
        }
    }
}
