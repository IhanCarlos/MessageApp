//
//  NavigationView.swift
//  MessageCursoViewCode
//
//  Created by ihan carlos on 09/02/23.
//

import UIKit
import SnapKit

enum TypeConversationOrContact {
    case conversation
    case contact
}

protocol NavViewProtocol:AnyObject {
    func typeScreenMessage(type:TypeConversationOrContact)
    
}

class NavigationView: UIView {
    
    weak private var delegate:NavViewProtocol?
    
    func delegate(delegate:NavViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var navBackgroundView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    lazy var navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var searchBar: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        return view
    }()

    lazy var searchLabel:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var searchButton:UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    let stackView:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        
        return stack
    }()
    
    lazy var conversationButton:UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bubble.left.and.bubble.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(self.tappedConversationButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var contactButton:UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "person.3.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(self.tappedContactButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc func tappedConversationButton() {
        self.delegate?.typeScreenMessage(type: .conversation)
        self.conversationButton.tintColor = .systemPink
        self.contactButton.tintColor = .black
    }
    
    @objc func tappedContactButton() {
        self.delegate?.typeScreenMessage(type: .contact)
        self.conversationButton.tintColor = .black
        self.contactButton.tintColor = .systemPink
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
        self.setUpConstraints()

    }
    
    func addElements() {
        self.addSubview(self.navBackgroundView)
        self.navBackgroundView.addSubview(self.navBar)
        self.navBar.addSubview(self.searchBar)
        self.navBar.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.conversationButton)
        self.stackView.addArrangedSubview(self.contactButton)
        self.searchBar.addSubview(self.searchLabel)
        self.searchBar.addSubview(self.searchButton)
        
    }
   
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -20),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            self.stackView.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -30),
            self.stackView.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.stackView.widthAnchor.constraint(equalToConstant: 100),
            self.stackView.heightAnchor.constraint(equalToConstant: 30),
            
            self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.searchButton.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            self.searchButton.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.searchButton.widthAnchor.constraint(equalToConstant: 20),
            self.searchButton.heightAnchor.constraint(equalToConstant: 20)
            
        
        ])
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
