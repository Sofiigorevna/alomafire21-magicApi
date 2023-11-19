//
//  DetailViewController.swift
//  alomafire21-magicApi
//
//  Created by 1234 on 11.10.2023.
//

import UIKit
class DetailViewController: UIViewController {
        
    let globalQueue =  DispatchQueue.global(qos: .utility)
    
    var character: Model? {
        didSet {
            name.text = "NAME: \(character?.name ?? "unknown")."
            type.text = "Type: \(character?.type ?? "unknown")."
            setName.text = "SetName: \(character?.setName ?? "unknown")."
            artist.text = "Artist: \(character?.artist ?? "unknown")."
            
            if  let imagePath = self.character?.imageUrl,
                let imageURL = URL(string: imagePath){
                
                globalQueue.async {
                    if let imageData = try? Data(contentsOf: imageURL){
                        DispatchQueue.main.async{
                            self.iconNew.image = UIImage(data: imageData )
                        }
                    }
                }
            } else {
                self.iconNew.image = UIImage(systemName: "person.fill")
                return
            }
        }
    }
    
    // MARK: - Outlets
    
    private lazy var iconNew: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewContainerNew: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var artist: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var setName: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var type: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [name, type, artist, setName])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.setCustomSpacing(2, after: name)
        stack.setCustomSpacing(2, after: type)
        stack.setCustomSpacing(2, after: artist)
        stack.setCustomSpacing(2, after: setName)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarhy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .lightGray
    }
    
    private func setupHierarhy() {
        view.addSubview(viewContainerNew)
        viewContainerNew.addSubview(iconNew)
        view.addSubview(stack)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewContainerNew.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewContainerNew.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            viewContainerNew.widthAnchor.constraint(equalToConstant: 250),
            viewContainerNew.heightAnchor.constraint(equalToConstant: 400),
            
            iconNew.centerXAnchor.constraint(equalTo: viewContainerNew.centerXAnchor),
            iconNew.centerYAnchor.constraint(equalTo: viewContainerNew.centerYAnchor),
            iconNew.topAnchor.constraint(equalTo: viewContainerNew.topAnchor, constant: 3),
            iconNew.leftAnchor.constraint(equalTo: viewContainerNew.leftAnchor, constant: 3),
            
            stack.topAnchor.constraint(equalTo: viewContainerNew.bottomAnchor, constant: 50),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 250),
            stack.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
}

