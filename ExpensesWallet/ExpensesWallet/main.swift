//
//  main.swift
//  ExpensesWallet
//
//  Created by Giovanni Madalozzo on 16/03/21.
//

import Foundation

var listAccounts: [Account] = []
var tools = Tools()

//STARTING MENU
listAccounts = tools.startMenu(listAccounts: listAccounts)
print(listAccounts[0].bank)

let earn = Purchases()

print(earn.recurrent())

