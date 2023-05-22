//
//  HomeVC.swift
//  MessageCursoViewCode
//
//  Created by ihan carlos on 09/02/23.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    var auth:Auth?
    var dp:Firestore?
    var idUsuarioLogado:String?
    
    var screenContact:Bool?
    var emailUsuarioLogado:String?
    var alert:Alert?
    
    var screen:HomeScreen?
    
    var contato:ContatoController?
    var listContact:[Contact] = []
    var listaConversas: [Conversation] = []
    var conversasListener:ListenerRegistration?
    
    
    override func loadView() {
        self.screen = HomeScreen()
        self.view = self.screen
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.addListenerRecuperarConversa()

    }
    private func configHomeView() {
        self.screen?.navView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        self.screen?.delegateCollectionView(delegate: self, dataSourse: self)
    }
    private func configAlert() {
        self.alert = Alert(controller: self)
    }
    private func configIdentifierFirebase() {
        self.auth = Auth.auth()
        self.dp = Firestore.firestore()
        
        //Recuperar id usuario logado
        if let currentUser = auth?.currentUser{
            self.idUsuarioLogado = currentUser.uid
            self.emailUsuarioLogado = currentUser.email
        }
    }
    
    private func configContato() {
        self.contato = ContatoController()
        self.contato?.delegate(delegate: self)
    }
    //carregar ultimas menssagens
    func addListenerRecuperarConversa() {
        if let idUsuarioLogado = auth?.currentUser?.uid{
            self.conversasListener = dp?.collection("conversas").document(idUsuarioLogado).collection("ultimas_conversas").addSnapshotListener({ querSnapshot, error in
                
                if error == nil{
                    
                    self.listaConversas.removeAll()
                    
                    if let snapshot = querSnapshot{
                        for document in snapshot.documents{
                            let dados = document.data()
                            self.listaConversas.append(Conversation(dicionario: dados))
                        }
                        self.screen?.reloadCollectionView()
                    }
                }
            })
        }
    }
    
    func getcontato(){
        self.dp?.collection("usuarios").document(self.idUsuarioLogado ?? "").collection("contatos").getDocuments(completion: { snapShotResultado, error in
            
            if error != nil{
                print("error getContato")
                return
            }
            
            if let snapshot = snapShotResultado{
                
                for document in snapshot.documents{
                    let dadosContato = document.data()
                    self.listContact.append(Contact(dicionario: dadosContato))
                }
                self.screen?.reloadCollectionView()
            }
        })
    }
}

extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.screenContact ?? false{
            return self.listContact.count + 1
        }else{
            return self.listaConversas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.screenContact ?? false{
            if indexPath.row == self.listContact.count{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageLastCollectionViewCell.identifier, for: indexPath)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
                cell?.setupViewContact(contact: self.listContact[indexPath.row])
                return cell ?? UICollectionViewCell()
            }
        }else{
            //Celula de Conversas
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
            cell?.setupViewConversation(conversation: self.listaConversas[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.screenContact ?? false{
            if indexPath.row == self.listContact.count{
                self.alert?.addContact(completion: { value in
                    self.contato?.addContact(email: value, emailUsuarioLogado: self.emailUsuarioLogado ?? "", idUsuario: self.idUsuarioLogado ?? "")
                })
            }
        }else{
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeVC:NavViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case.contact:
            self.screenContact = true
            self.getcontato()
            self.conversasListener?.remove()
        case.conversation:
            self.screenContact = false
            self.addListenerRecuperarConversa()
            self.screen?.reloadCollectionView()
        }
    }
    
}

extension HomeVC:contatoProtocol {
    func alertStateError(titulo: String, message: String) {
        self.alert?.getAlert(title: titulo, mensager: message)
    }
    
    func sucessoContato() {
        self.alert?.getAlert(title: "Sucesso", mensager: "Usuáro Cadastrado", complition: {
            self.getcontato()
        })
    }
    
    
}
