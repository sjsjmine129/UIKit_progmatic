//
//  MyViewController.swift
//  UIKit_progmatic
//
//  Created by 엄승주 on 2/4/24.
//

import UIKit
import SwiftUI

class MyViewController: UIViewController {
    
    lazy var myNameTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // use auto layout
        label.text = "리이오"
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false // use auto layout
        button.setTitle("인사해주세요!", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        view.addSubview(myNameTextLabel) // render lbl
        // locate lbl
        myNameTextLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myNameTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myNameTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myNameTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(changeButton) // add btn
        // locate btn
        changeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        changeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeButton.topAnchor.constraint(equalTo: myNameTextLabel.bottomAnchor, constant: 200).isActive = true
        
        // set action to btn
        changeButton.addTarget(self, action: #selector(didTapChangeNameButton), for: .touchUpInside)
        
    }
    
    // press button
    @objc func didTapChangeNameButton(){
        myNameTextLabel.text = "안녕!"
    }
    
    
}


struct PreView: PreviewProvider {
    static var previews: some View {
        MyViewController().toPreview()
    }
}


#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
