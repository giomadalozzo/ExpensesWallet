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
        add gasto - Opção para adicionar gastos recorrentes
        add crédito - Opção para adicionar crédito recorrentes
        editar - Opção para editar uma transação
        deletar - Opção para deletar uma transação
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
        case "add gasto":
            var purchases = Purchases()
            print(purchases.add(account: selectedAccount))
        case "add crédito":
            var earnings = Earnings()
            earnings.add(account: selectedAccount)
        case "editar":
            self.editEntry(selectedAccount: selectedAccount)
        case "deletar":
            self.removeEntry(selectedAccount: selectedAccount)
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
    
        print("""
        \nBEM VINDO AO MENU DE AJUDA\n
        info: esta opção mostra as informações da conta selecionada. Ela exibe o tipo de conta, o banco ao qual a conta pertence e o apelido da conta. Para selecioná-la, digite 'info' no terminal (sem as aspas).\n
        extrato: esta opção mostra o extrato da conta selecionada. Ela exibe as datas das transações, mostra se foi um crédito ou um débito e mostra o valor das transações. Para selecioná-la, digite 'extrato' no terminal (sem as aspas).\n
        add gasto: esta opção permite ao usuário inserir uma transação de débito. Ela permite que o usuário entre com o valor do débito e também o dia da transação. Para selecioná-la, digite 'add gasto' no terminal (sem as aspas).\n
        add crédito: esta opção permite ao usuário inserir uma transação de crédito. Ela permite que o usuário entre com o valor do crédito e também o dia da transação. Para selecioná-la, digite 'add crédito' no terminal (sem as aspas).\n
        editar: esta opção permite a edição de uma transação feita pelo usuário. O usuário pode selecionar a transação e editar qualquer característica da mesma. Para selecioná-la, digite 'editar' no terminal (sem as aspas).\n
        deletar: esta opção permite deletar uma transação feita pelo usuário. O usuário pode selecionar a transação e deletá-la. Para selecioná-la, digite 'deletar' no terminal (sem as aspas).\n
        voltar: esta opção retorna ao menu de seleção de contas e permite que o usuário mude a conta com a qual está trabalhando. Para selecioná-la, digite 'voltar' no terminal (sem as aspas).\n
        sair: esta opção encerra o programa. Para voltar a utilizar o ExpensesWallet, o usuário deve iniciar o programa novamente. Para selecionar esta opção, digite 'sair' no terminal (sem as aspas).\n
        help: esta opção abre este menu de ajuda com as explicações das funções do programa. Caso queira visualizar o menu de ajuda novamente, digite 'help' no terminal (sem as aspas).\n
        """)
    }
    
    func editEntry(selectedAccount: Account){
        print("\nEDITOR DE TRANSAÇÕES\n")
        if selectedAccount.historic.isEmpty{
            print("Nenhuma transação registrada")
        }else{
            print("Selecione qual transação deseja editar: ")
            self.sortHistoric(selectedAccount: selectedAccount)
            
            var indexes: [Int] = []
            for (index,item) in selectedAccount.historic.enumerated(){
                print("\(index+1) - Data da transação: \(item[0]) | Tipo da transação: \(item[1]) | Valor da transação: \(item[2])")
                indexes.append(index)
            }
            let transaction = readLine()
            guard let indexUnwrapped = transaction else{
                print("Opção inválida. Retornando para o menu.")
                self.editEntry(selectedAccount: selectedAccount)
                return
            }
            guard let  indexIntAux = Int(indexUnwrapped) else{
                print("Opção inválida. Retornando para o menu.")
                self.editEntry(selectedAccount: selectedAccount)
                return
            }
            let indexInt = indexIntAux-1
            
            if indexes.contains(indexInt){
                print("\n TRANSAÇÃO ESCOLHIDA: Data da transação: \(selectedAccount.historic[indexInt][0]) | Tipo da transação: \(selectedAccount.historic[indexInt][1]) | Valor da transação: \(selectedAccount.historic[indexInt][2])\n")
                print("Deseja alterar o tipo de transação? (s/n)")
                let transactionChange = readLine()
                
                switch transactionChange{
                case "s":
                    if selectedAccount.historic[indexInt][1] == "Crédito" {
                        print("Troca da transação para débito realizada com sucesso!\n")
                        selectedAccount.historic[indexInt][1] = "Débito"
                    }else{
                        print("Troca da transação para crédito realizada com sucesso!\n")
                        selectedAccount.historic[indexInt][1] = "Crédito"
                    }
                case "n":
                    print("\n")
                default:
                    print("Opção inválida, tente novamente.")
                    self.editEntry(selectedAccount: selectedAccount)
                }
                
                print("Deseja alterar a data da transação? (s/n)")
                let dateChange = readLine()
                
                switch dateChange{
                case "s":
                    print("\nDigite o novo dia: ")
                    let newDay = readLine()
                    guard let unwrappedDate2 = newDay else {
                        print("Nenhuma data digitada, tente novamente.")
                        self.editEntry(selectedAccount: selectedAccount)
                        return
                    }
                    guard let unwrappedDate = Int(unwrappedDate2) else{
                        print("Valor não reconhecido, tente novamente.")
                        self.editEntry(selectedAccount: selectedAccount)
                        return
                    }
                    
                    let now = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "LL"
                    let dateMonth = Int(dateFormatter.string(from: now))
                    dateFormatter.dateFormat = "YYYY"
                    let dateYear = Int(dateFormatter.string(from: now))
                    
                    
                    var comp = DateComponents(calendar: .current, year: dateYear, month: dateMonth, day: unwrappedDate)

                    dateFormatter.dateStyle = .short
                    dateFormatter.timeStyle = .none
                    
                    selectedAccount.historic[indexInt][0] = "\(dateFormatter.string(from: comp.date!))"
                    
                    print("Data mudada para \(selectedAccount.historic[indexInt][0]) com sucesso!\n")
                case "n":
                    print("\n")
                default:
                    print("Opção inválida, tente novamente.")
                    self.editEntry(selectedAccount: selectedAccount)
                }
                
                print("Deseja alterar o valor da transação? (s/n)")
                let valueChange = readLine()
                
                switch valueChange{
                case "s":
                    print("Digite o novo valor: ")
                    let newValue = readLine()
                    
                    guard let unwrappedValue = newValue else {
                        print("Valor não reconhecido, tente novamente.")
                        self.editEntry(selectedAccount: selectedAccount)
                        return
                    }
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .currency
                    numberFormatter.locale = Locale.current
                    guard let valueDouble = Double(unwrappedValue) else{
                        print("Valor não reconhecido, tente novamente.")
                        self.editEntry(selectedAccount: selectedAccount)
                        return
                    }
                    let valueNS = NSNumber(value: valueDouble)
                    guard let unwrappedValue2 = numberFormatter.string(from: valueNS) else{
                        print("Valor não reconhecido, tente novamente.")
                        self.editEntry(selectedAccount: selectedAccount)
                        return
                    }
                    selectedAccount.historic[indexInt][2] = unwrappedValue2
                    
                    print("Valor mudado para \(selectedAccount.historic[indexInt][2]) com sucesso!\n")
                case "n":
                    print("\n")
                default:
                    print("Opção inválida, tente novamente.")
                    self.editEntry(selectedAccount: selectedAccount)
                }
                print("\nEdição realizada com sucesso! Data da transação: \(selectedAccount.historic[indexInt][0]) | Tipo da transação: \(selectedAccount.historic[indexInt][1]) | Valor da transação: \(selectedAccount.historic[indexInt][2])\n")
            }else{
                print("Opção inválida. Retornando para o menu.")
            }
        }
    }
    
    func removeEntry(selectedAccount: Account) {
        print("\nDELETAR TRANSAÇÃO\n")
        if selectedAccount.historic.isEmpty{
            print("Nenhuma transação registrada")
        }else{
            print("Selecione qual transação deseja deletar: ")
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
            guard let  indexIntAux = Int(indexUnwrapped) else{
                print("Opção inválida. Retornando para o menu.")
                return
            }
            let indexInt = indexIntAux-1
            
            if indexes.contains(indexInt){
                selectedAccount.historic.remove(at: indexInt)
                print("\nTransação removida com sucesso!")
            }else{
                print("Opção inválida. Retornando para o menu.")
            }
        }
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
