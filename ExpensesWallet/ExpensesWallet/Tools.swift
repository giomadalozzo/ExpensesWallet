//
//  Tools.swift
//  ExpensesWallet
//
//  Created by Giovanni Madalozzo on 16/03/21.
//

import Foundation

struct Tools {
    
    func startMenu(listAccounts:[Account]) ->[Account]{
        var listAccounts = listAccounts
        print("""
        Por favor, digite a opção que deseja:
        selecionar - Opção para selecionar uma conta já existente
        criar - Opção para criar uma nova conta
        sair - Opção para sair do programa
        """)
        
        let option = readLine()
        
        switch option {
        case "selecionar":
            self.selectAccount()
        case "criar":
            listAccounts = self.registerAccount(listAccounts: listAccounts)
        case "sair":
            self.quit()
        default:
            print("Nenhuma opção identificada. \n")
            self.startMenu(listAccounts: listAccounts)
        }
        return listAccounts
    }
    
    func accountMenu(){
    
    }
    
    func help(){
        
    }
    
    func edit(){
        
    }
    
    func remove() {
        
    }
    
    func registerAccount(listAccounts: [Account]) -> [Account]{
        var listAccounts = listAccounts
        print("Digite o tipo da conta (corrente ou poupança): ")
        let type = readLine()
        guard let typeUnwrapped = type else{
            print("Nenhum valor digitado. Retornando para o menu.")
            return listAccounts
        }
        
        print("Digite o banco da conta: ")
        let bank = readLine()
        guard let bankUnwrapped = bank else{
            print("Nenhum valor digitado. Retornando para o menu.")
            return listAccounts
        }
        
        print("Digite um apelido para a conta:")
        let nickname = readLine()
        guard let nicknameUnwrapped = nickname else{
            print("Nenhum valor digitado. Retornando para o menu.")
            return listAccounts
        }
        
        var newAccount = Account(type: typeUnwrapped, bank: bankUnwrapped, nickname: nicknameUnwrapped)
        
        listAccounts.append(newAccount)
        
        print("Nova conta registrada com sucesso!")
        
        return listAccounts
    }
    
    func selectAccount() {
        print("SELECIONANDO")
    }
    
    func quit(){
        print("Até mais!")
        exit(0)
    }
    
    
}
