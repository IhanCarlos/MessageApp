//
//  MessageDetailCollectionViewCell.swift
//  MessageCursoViewCode
//
//  Created by ihan carlos on 17/02/23.
//

import UIKit

class MessageDetailCollectionViewCell: UICollectionViewCell {
    
    var navigation = NavigationView()
    
    static let identifier:String = "MessageDetailCollectionViewCell"
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 26
        image.image = UIImage(systemName: "lifepreserver.fill")
        
        return image
    }()
    
    lazy var userName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(userName)
        setupConstraints()
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewContact(contact:Contact){
        self.setUserName(username: contact.nome ?? "")
    }
    
    func setupViewConversation(conversation:Conversation){
        self.setUserNameattributedText(conversation)
    }
    
    func setUserNameattributedText(_ conversation:Conversation) {
        let attributedText = NSMutableAttributedString(string: "\(conversation.nome ?? "")", attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "/n\(conversation.ultimaMensagem ?? "")" , attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
        
        self.userName.attributedText = attributedText
    }
    
    func setUserName(username:String){
        let attribultText = NSMutableAttributedString(string: username, attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        self.userName.attributedText = attribultText
    }
}

