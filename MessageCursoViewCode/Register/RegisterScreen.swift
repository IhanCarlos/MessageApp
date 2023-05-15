//
//  RegisterScreen.swift
//  StudyViewCode
//
//  Created by ihan carlos on 29/11/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class RegisterScreen: UIView {
    
    weak private var delegate: RegisterScreenProtocol?
    
    func delegate(delegate:RegisterScreenProtocol?){
        self.delegate = delegate
    }
    //Botao voltar
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward" ), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        
        return button
    }()
    //imagem
    lazy var imageAddUser: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill.badge.plus")
        image.contentMode = .scaleAspectFit
        image.tintColor = .green
        
        return image
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu nome"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf
    }()
    //campo de email
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu email"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf
    }()
    //campo de senha
    lazy var passwordTextField: UITextField = {
        let pf = UITextField()
        pf.translatesAutoresizingMaskIntoConstraints = false
        pf.autocorrectionType = .no
        pf.backgroundColor = .white
        pf.borderStyle = .roundedRect
        pf.keyboardType = .default
        pf.placeholder = "Crie sua senha"
        pf.isSecureTextEntry = true
        pf.font = UIFont.systemFont(ofSize: 14)
        pf.textColor = .darkGray
        
        return pf
    }()
    //botao de resgistro
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
//MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setUpConstraits()
        self.configButtonEnable(false)
        
    }
    //subviews
    private func configSuperView() {
        self.addSubview(self.backButton)
        self.addSubview(self.imageAddUser)
        self.addSubview(self.nameTextField)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.registerButton)
    }
    
    private func configBackGround() {
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
    //delegate
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.nameTextField.delegate = delegate
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    @objc private func tappedRegisterButton(){
        self.delegate?.actionRegisterButton()
    }
    
    public func valideTextField(){
        let name: String = self.nameTextField.text ?? ""
        let email: String = self.emailTextField.text ?? ""
        let password: String = self.passwordTextField.text ?? ""
        
        //MARK: Validacao de campo
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            self.configButtonEnable(true)
        } else {
            self.configButtonEnable(false)
        }
    }
    
    private func configButtonEnable (_ enable:Bool){
        if enable {
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        } else {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        }
    }
    
    public func getName() -> String {
        return self.nameTextField.text ?? ""
    }
    
    public func getEmail() -> String {
        return self.emailTextField.text ?? ""
    }
    
    public func getpassword() -> String {
        return self.passwordTextField.text ?? ""
    }
    
    //erro
    required init?(coder: NSCoder) {
        fatalError("Init(coder) is failed")
    }
    
    //MARK: Constranints
    
    // maneira nativa
    
    private func setUpConstraits() {
        NSLayoutConstraint.activate([
          //   Image addUser
            self.imageAddUser.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.imageAddUser.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageAddUser.widthAnchor.constraint(equalToConstant: 150),
            self.imageAddUser.heightAnchor.constraint(equalToConstant: 150),
            // Button Back
            self.backButton.topAnchor.constraint(equalTo: self.imageAddUser.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.backButton.widthAnchor.constraint(equalToConstant: 20),
            self.backButton.heightAnchor.constraint(equalToConstant: 20),
            // Name
            self.nameTextField.topAnchor.constraint(equalTo: self.imageAddUser.bottomAnchor, constant: 10),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 45),
          //  Email
            self.emailTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 15),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
          //  Password
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 15),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
           // Button Register
            self.registerButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 15),
            self.registerButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.registerButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.registerButton.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor)
        ])
    }
}
