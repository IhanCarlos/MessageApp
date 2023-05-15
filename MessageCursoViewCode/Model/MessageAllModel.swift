//
//  File.swift
//  MessageCursoViewCode
//
//  Created by ihan carlos on 16/02/23.
//

import Foundation

class message {
    var texto:String?
    var idUsuario:String?
    
    init(dicionario:[String:Any]) {
        self.texto = dicionario["texto"] as? String // afirmar que é uma string
        self.idUsuario = dicionario["idUsuário"] as? String
    }
}

class Conversation{
    
    var nome:String?
    var ultimaMensagem:String?
    var idDestinatario:String?
    
    init(dicionario:[String:Any]) {
        self.nome = dicionario["nomeUsuario"] as? String // afirmar que é uma string
        self.ultimaMensagem = dicionario["idUsuário"] as? String
        self.ultimaMensagem = dicionario["idDestinatario"] as? String
    }
}

class User{
    
    var nome:String?
    var email:String?
    
    init(dicionario:[String:Any]) {
        self.nome = dicionario["nome"] as? String // afirmar que é uma string
        self.email = dicionario["email"] as? String
    }
}
    
class Contact {
    var id:String?
    var nome:String?
    
    init(dicionario:[String:Any]?) {
        self.nome = dicionario?["nome"] as? String // afirmar que é uma string
        self.id = dicionario?["id"] as? String
    }
    
    convenience init(id:String?, nome:String?) {
        self.init(dicionario:nil)
        self.id = id
        self.nome = nome
    }
}
