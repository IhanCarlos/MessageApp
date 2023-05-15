//
//  ViewController.swift
//  StudyViewCode
//
//  Created by ihan carlos on 24/11/22.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    var loginScreen:LoginScreen?
    var auth:Auth?
    var alert:Alert?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false) // habilitar ou desabilitar a navigation
    }
}
// validacao de login
extension LoginVC: LoginScreenProtocol {
    func actionLoginButton() {
        
        guard let login = self.loginScreen else {return}

        self.auth?.signIn(withEmail: login.getEmail(), password: login.getpassword(), completion: { (usuario, error) in

            if error != nil {
                self.alert?.getAlert(title: "Atenção", mensager: "Atenção, dados incorretos! Verifique e tente novamente")
            }else{

                if usuario == nil {
                    self.alert?.getAlert(title: "Atenção", mensager: "Ouve um erro inesperado, tente novamente mais tarde!")
                }else{
                    //self.alert?.getAlert(title: "Sucesso", mensager: "Usuário logado com sucesso!")
                    let vc = HomeVC()
                    let navVc = UINavigationController(rootViewController: vc)
                    navVc.modalPresentationStyle = .fullScreen
                    self.present(navVc, animated: true, completion: nil)
                }
            }
        })
    
    }
    
    func actionRegisterButton() {
        // Navegacao para outra tela 
        let vc:RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.valideTextField()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() 
    }
}
