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
            if listAccounts.isEmpty{
                print("\nVocê não tem contas registradas. Por favor, registre uma nova conta.")
                listAccounts = self.registerAccount(listAccounts: listAccounts)
            } else{
                var selectedAccount: Account
                selectedAccount = self.selectAccount(listAccounts: listAccounts)
                print("Conta selecionada: \(selectedAccount.nickname)")
                self.accountMenu(selectAccount: selectedAccount)
            }
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
    
    func accountMenu(selectAccount: Account){
        print("""
        \nMENU DE OPÇÕES DA CONTA\n
        Por favor, digite a opção que deseja:
        info - Opção para exibir as informações da conta selecionada
        extrato - Opção para exibir o histórico da conta
        addrec gasto - Opção para adicionar gastos recorrentes
        addrec crédito - Opção para adicionar crédito recorrentes
        voltar - Opção para voltar para o menu de seleção de contas
        sair - Opção para sair do programa
        """)
        
        let option = readLine()
        
        switch option {
        case "info":
            print("Tipo: \(selectAccount.type) Banco: \(selectAccount.bank) Apelido: \(selectAccount.nickname)")
        case "extrato":
            selectAccount.report(account: selectAccount)
        case "sair":
            self.quit()
        case "addrec gasto":
            var add = Purchases()
            print(add.recurrent(account: selectAccount))
        case "addrec crédito":
            var add = Earnings()
            add.recurrent(account: selectAccount)
        case "voltar":
            self.startMenu(listAccounts: listAccounts)
        default:
            print("Nenhuma opção identificada. \n")
            self.startMenu(listAccounts: listAccounts)
        }
        
        self.accountMenu(selectAccount: selectAccount)
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
    
    func selectAccount(listAccounts: [Account]) -> Account{
        
        print("\nSELECIONE A CONTA DESEJADA:")
        for (index, account) in listAccounts.enumerated() {
            print("Opção \(index+1) - Tipo: \(account.type)  Banco: \(account.bank)  Apelido: \(account.nickname)")
        }
        
        let option = readLine()
        guard let optionUnwrapped = option else{
            print("Opção não reconhecida. Retornando para o menu.")
            return listAccounts[0]
        }
        guard let optionInt = Int(optionUnwrapped) else{
            print("Opção não reconhecida. Retornando para o menu.")
            return listAccounts[0]
        }

        return listAccounts[optionInt-1]
    }
    
    func quit(){
        print("Até mais!")
        exit(0)
    }
    
    
}
