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
        sair - Opção para sair do programa
        help - Opção para abrir o menu de ajuda\n
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
        case "help":
            self.helpStartMenu()
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
        sair - Opção para sair do programa
        help - Opção para abrir o menu de ajuda\n
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
        case "help":
            self.helpAccountMenu()
        default:
            print("Nenhuma opção identificada. \n")
            self.accountMenu(selectedAccount: selectedAccount)
        }
        
        self.accountMenu(selectedAccount: selectedAccount)
    }
    
    func helpStartMenu(){

        print("""
        \nBEM VINDO AO MENU DE AJUDA\n
        selecionar: esta opção permite que o usuário escolha uma das contas inseridas no programa pelo usuário. Para acessar uma conta a partir desta opção, basta digitar o número da conta desejada que é informado na tela. Para selecionar esta opção, digite 'selecionar' no terminal (sem as aspas).\n
        criar: esta opção permite ao usuário inserir uma nova conta no programa. Nesta opção, o usuário pode entrar com o tipo de conta (corrente ou poupança), o banco ao qual a conta pertence e também um apelido para a conta. Para selecioná-la, digite 'criar' no terminal (sem as aspas).\n
        sair: esta opção encerra o programa. Para voltar a utilizar o ExpensesWallet, o usuário deve iniciar o programa novamente. Para selecionar esta opção, digite 'sair' no terminal (sem as aspas).\n
        """)

    }
    
    func helpAccountMenu(){
        //info: opção utilizada para mostrar as informações da conta selecionada. Para selecioná-la, escreva "info" no terminal (sem as aspas)
        print("""
        \nBEM VINDO AO MENU DE AJUDA\n
        info: esta opção mostra as informações da conta selecionada. Ela exibe o tipo de conta, o banco ao qual a conta pertence e o apelido da conta. Para selecioná-la, digite 'info' no terminal (sem as aspas).\n
        extrato: esta opção mostra o extrato da conta selecionada. Ela exibe as datas das transações, mostra se foi um crédito ou um débito e mostra o valor das transações. Para selecioná-la, digite 'extrato' no terminal (sem as aspas).\n
        addrec gasto: esta opção permite ao usuário inserir uma transação de débito. Ela permite que o usuário entre com o valor do débito e também o dia da transação. Para selecioná-la, digite 'addrec gasto' no terminal (sem as aspas).\n
        addrec crédito: esta opção permite ao usuário inserir uma transação de crédito. Ela permite que o usuário entre com o valor do crédito e também o dia da transação. Para selecioná-la, digite 'addrec crédito' no terminal (sem as aspas).\n
        voltar: esta opção retorna ao menu de seleção de contas e permite que o usuário mude a conta com a qual está trabalhando. Para selecioná-la, digite 'voltar' no terminal (sem as aspas).\n
        sair: esta opção encerra o programa. Para voltar a utilizar o ExpensesWallet, o usuário deve iniciar o programa novamente. Para selecionar esta opção, digite 'sair' no terminal (sem as aspas).\n
        help: esta opção abre este menu de ajuda com as explicações das funções do programa. Caso queira visualizar o menu de ajuda novamente, digite 'help' no terminal (sem as aspas).\n
        """)
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
