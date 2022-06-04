//
//  MyCustomHeader.swift
//  Pozolotina_VK
//
//  Created by angelina on 27.04.2022.
//
//
//import UIKit
//
//class MyCustomHeader: UITableViewHeaderFooterView {
//
//        let title = UILabel()
//        let image = UIImageView()
//        let view = UIView()
//
//        override init(reuseIdentifier: String?) {
//            super.init(reuseIdentifier: reuseIdentifier)
//            configureContents()
//            image.layer.cornerRadius = image.frame.size.width / 2
//            image.layer.masksToBounds = true
//
//        }
//
//    required init?(coder: NSCoder) {
//
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func awakeFromNib() {
//
//    }
//    
//        func configureContents() {
//            image.translatesAutoresizingMaskIntoConstraints = false
//            title.translatesAutoresizingMaskIntoConstraints = false
//            view.translatesAutoresizingMaskIntoConstraints = false
//            
//            contentView.addSubview(view)
//            contentView.addSubview(image)
//            contentView.addSubview(title)
//            
//            // Center the image vertically and place it near the leading
//            // edge of the view. Constrain its width and height to 50 points.
//            NSLayoutConstraint.activate([
//                view.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//                view.widthAnchor.constraint(equalToConstant: 50),
//                view.heightAnchor.constraint(equalToConstant: 50),
//                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//                
//                
//                image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//                image.widthAnchor.constraint(equalToConstant: 50),
//                image.heightAnchor.constraint(equalToConstant: 50),
//                image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
//                // Center the label vertically, and use it to fill the remaining
//                // space in the header view.
//                title.heightAnchor.constraint(equalToConstant: 30),
//                title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
//                       constant: 8),
//                title.trailingAnchor.constraint(equalTo:
//                       contentView.layoutMarginsGuide.trailingAnchor),
//                title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//                
//               
//            ])
//            
//        }
//  
//}
//
//
