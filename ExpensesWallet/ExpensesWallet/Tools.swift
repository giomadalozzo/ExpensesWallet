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
        \nPor favor, digite a opção que deseja:
        selecionar - Opção para selecionar uma conta bancária já existente
        criar - Opção para criar uma nova conta bancária
        sair - Opção para sair do programa\n
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
                self.accountMenu(selectedAccount: selectedAccount)
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
    
    func accountMenu(selectedAccount: Account){
        print("""
        \nMENU DE OPÇÕES DA CONTA\n
        Por favor, digite a opção que deseja:
        info - Opção para exibir as informações da conta selecionada
        extrato - Opção para exibir o histórico da conta
        addrec gasto - Opção para adicionar gastos recorrentes
        addrec crédito - Opção para adicionar crédito recorrentes
        voltar - Opção para voltar para o menu de seleção de contas
        sair - Opção para sair do programa\n
        """)
        
        let option = readLine()
        
        switch option {
        case "info":
            print("\nTipo: \(selectedAccount.type) | Banco: \(selectedAccount.bank) | Apelido: \(selectedAccount.nickname)")
        case "extrato":
            self.sortHistoric(selectedAccount: selectedAccount)
            selectedAccount.report(account: selectedAccount)
        case "sair":
            self.quit()
        case "addrec gasto":
            var purchases = Purchases()
            print(purchases.add(account: selectedAccount))
        case "addrec crédito":
            var earnings = Earnings()
            earnings.add(account: selectedAccount)
        case "voltar":
            self.startMenu(listAccounts: listAccounts)
        default:
            print("Nenhuma opção identificada. \n")
            self.accountMenu(selectedAccount: selectedAccount)
        }
        
        self.accountMenu(selectedAccount: selectedAccount)
    }
    
    func helpStartMenu(){
        
    }
    
    func helpAccountMenu(){
        
    }
    
    func editEntry(selectedAccount: Account){
        print("\nEDITOR DE TRANSAÇÕES\n")
        print("Selecione qual transação deseja editar: ")
        self.sortHistoric(selectedAccount: selectedAccount)
        
        var indexes: [Int] = []
        for (index,item) in selectedAccount.historic.enumerated(){
            print("\(index+1) - Data da transação: \(item[0]) | Tipo da transação: \(item[1]) | Valor da transação: \(item[2])")
            indexes.append(index)
        }
        let transaction = readLine()
        guard let indexUnwrapped = transaction else{
            print("Opção innválida. Retornando para o menu.")
            return
        }
        guard let  indexInt = Int(indexUnwrapped) else{
            print("Opção inválida. Retornando para o menu.")
            return
        }
        
        if indexes.contains(indexInt){
            print("\n TRANSAÇÃO ESCOLHIDA: Data da transação: \(selectedAccount.historic[indexInt][0]) | Tipo da transação: \(selectedAccount.historic[indexInt][1]) | Valor da transação: \(selectedAccount.historic[indexInt][2])\n")
            print("Deseja alterar o tipo de transação? (s/n)")
            let transactionChange = readLine()
            
            switch transactionChange{
            case "s":
                if selectedAccount.historic[indexInt][1] == "Crédito" {
                    print("Mudando a transação para débito...\n")
                    selectedAccount.historic[indexInt][1] = "Débito"
                }else{
                    print("Mudando a transação para crédito...\n")
                    selectedAccount.historic[indexInt][1] = "Crédito"
                }
            case "n":
                print("\n")
            default:
                print("Opção inválida, tente novamente.")
                self.editEntry(selectedAccount: selectedAccount)
            }
            
        }
        
    }
    
    func removeEntry(selectedAccount: Account) {
        
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
    
    func sortHistoric(selectedAccount: Account){
        selectedAccount.historic = selectedAccount.historic.sorted(by: {
             ($0[0]) < ($1[0])
        })
    }
    
    
}
