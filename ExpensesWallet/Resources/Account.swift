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
    
    init(String type, String bank, String nickname) {
        self.type = type
        self.bank = bank
        self.nickname = nickname
    }
    
    func report() {
        
    }
}
