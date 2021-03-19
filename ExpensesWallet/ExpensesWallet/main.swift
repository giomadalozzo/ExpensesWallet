//
//  main.swift
//  ExpensesWallet
//
//  Created by Giovanni Madalozzo on 16/03/21.
//

import Foundation

//MOCKING ACCOUNTS AND TRANSACTIONS
var listAccounts: [Account] = [Account(type: "Corrente", bank: "Bubank", nickname: "Verdinha"), Account(type: "Poupança", bank: "SaintAndré", nickname: "Pensão")]
listAccounts[0].historic = [["02/03/2021", "Débito", "R$ 12,50"], ["14/03/2021", "Crédito", "R$ 5.000,00"], ["15/03/2021", "Débito", "R$ 1.110,00"], ["23/03/2021", "Crédito", "R$ 500,00"]]
listAccounts[1].historic = [["07/03/2021", "Crédito", "R$ 300,50"], ["12/03/2021", "Crédito", "R$ 3.500,00"], ["20/03/2021", "Débito", "R$ 910,00"], ["28/03/2021", "Crédito", "R$ 500,00"]]


//STARTING TOOLS
var tools = Tools()

//STARTING MAIN MENU
print("""
    \n\n\n

                                       BEM VINDO!

                                        ▄█▀└▀▀▄
                                        █  💲 █
                                         ▀▄▄▄▓
     
                                ▓▄µ ╓▄▓▀▀▀▓▓▓▓▓▀▀▀▓▄
                                ▐▌█▀▐▄▀▀█╙┌   ¬`    ▀▀▄,
                               ▄█▀  ▀   █▄             ▀▓
                              ▓▀  ▄▄⌐   ▐▌               █    ▄▀▀
                          ,,,▄█  "▀▀▀                     █ ,▓▀
                         ▓▀▀█└                            █▀▀
                         █▌"█     ,                       █
                          ▀▀▀▀██▀▀▀`                     ▄▌
                               ▀▄                       ▓▀
                                ██▄                    █
                                █ █⌐  .▄        ,▄▄▄   █
                                █▄█▄,,▐▌└▀▀▀▀▀▀▀█▄▐▌,,,█
                                 .▐▌¬└▐▌         └▐▌└'▐▌

         _____  _____ ___ _  _ ___ ___ ___  __      ___   _    _    ___ _____
        | __\\ \\/ / _ \\ __| \\| / __| __/ __| \\ \\    / /_\\ | |  | |  | __|_   _|
        | _| >  <|  _/ _|| .` \\__ \\ _|\\__ \\  \\ \\/\\/ / _ \\| |__| |__| _|  | |
        |___/_/\\_\\_| |___|_|\\_|___/___|___/   \\_/\\_/_/ \\_\\____|____|___| |_|
                                                                        

    """)

listAccounts = tools.startMenu(listAccounts: listAccounts)


//CRIAR EDITAR E REMOVER PARA CONTAS!
