//
//  ContatoController.swift
//  MessageCursoViewCode
//
//  Created by ihan carlos on 22/02/23.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol contatoProtocol:AnyObject {
    func alertStateError(titulo:String, message:String)
    func sucessoContato()
}

class ContatoController {
    
    weak var delegate:contatoProtocol?
    
    public func delegate(delegate:contatoProtocol?){
        self.delegate = delegate
    }
    
    func addContact(email:String, emailUsuarioLogado:String, idUsuario:String) {
        if email == emailUsuarioLogado {
            self.delegate?.alertStateError(titulo: "voce adicionou seu proprio email", message: "adicione um email diferente")
            return
        }
        
        // verificar se existe outro usuario no firebase
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshotResultado, error in
            
            // conta total de retorno
            if let totalItens = snapshotResultado?.count {
                if totalItens == 0{
                    self.delegate?.alertStateError(titulo: "usuario nao cadastrado", message: "verifique o e-mail")
                    return
                }
                //salvar contato
                if let snapshot = snapshotResultado{
                    for document in snapshot.documents{
                        let dados = document.data()
                        self.salvarContato(dadosContato: dados, idUsuario: idUsuario)
                    }
                }
            }
        }
    }
    func salvarContato(dadosContato:Dictionary<String,Any>, idUsuario:String){
        let contact:Contact = Contact(dicionario: dadosContato)
        let firestore:Firestore = Firestore.firestore()
        firestore.collection("usuarios").document(idUsuario).collection("contatos").document(contact.id ?? "").setData(dadosContato){(error) in
            if error == nil{
                self.delegate?.sucessoContato()
            }
        }
    }
}
