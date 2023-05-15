//
//  RegisterVC.swift
//  StudyViewCode
//
//  Created by ihan carlos on 29/11/22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    var registerScreen: RegisterScreen?
    
    var auth:Auth?
    var fireStore:Firestore?
    var alert:Alert?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.fireStore = Firestore.firestore()
        self.alert = Alert(controller: self)
    }
 
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.valideTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterVC: RegisterScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true) // Voltar para tela anterios
    }
    
    func actionRegisterButton() {
        guard let register = self.registerScreen else {return}

        self.auth?.createUser(withEmail: register.getEmail(), password: register.getpassword(), completion: { (result, error) in

            if error != nil { // se error for diferente de nil
                self.alert?.getAlert(title: "Atenção", mensager: "Erro ao cadastrar, tente navamente!")
            }else{
                
                //Salvar dados no firestore
                if let idUsuario = result?.user.uid{
                    self.fireStore?.collection("usuario").document(idUsuario).setData([
                        "nome":self.registerScreen?.getName() ?? "",
                        "email":self.registerScreen?.getEmail() ?? "",
                        "id":idUsuario
                    ])
                }
                self.alert?.getAlert(title: "Sucesso", mensager: "Usuário criado com sucesso", complition: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        })
        
    }
    
    
}
