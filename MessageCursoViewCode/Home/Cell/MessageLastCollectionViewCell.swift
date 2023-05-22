//
//  MessageCollectionViewCell.swift
//  MessageCursoViewCode
//
//  Created by ihan carlos on 17/02/23.
//

import UIKit

class MessageLastCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = "MessageCollectionViewCell"
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.image = UIImage(systemName: "person.badge.plus")
        image.tintColor = .lightGray
        
        return image
    }()
    
    lazy var userName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicionar novo contato"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.imageView)
        addSubview(self.userName)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        
        ])
    }
}
