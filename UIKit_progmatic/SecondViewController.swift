//
//  SecondViewController.swift
//  UIKit_progmatic
//
//  Created by 엄승주 on 2/6/24.
//

import UIKit
import SwiftUI

class SecondViewController: UIViewController {
    
    let diceImage = ["one", "two", "three", "four", "five", "six"]
    
    lazy var lblDouble : UILabel = {
        let lbl = UILabel()
        lbl.text = "Start game"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    lazy var playStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .lightGray
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var diceImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "one"))
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    lazy var diceImageView2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "one"))
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false // use auto layout
        button.setTitle("Dice Roll!!", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        // add stack
        view.addSubview(playStackView)
        
        // add constraint
        playStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        playStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        playStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        playStackView.addArrangedSubview(diceImageView)
        playStackView.addArrangedSubview(diceImageView2)
        
        // add lbl
        view.addSubview(lblDouble)
        
        // locate lbl
        lblDouble.topAnchor.constraint(equalTo: playStackView.bottomAnchor, constant: 50).isActive = true
        lblDouble.centerXAnchor.constraint(equalTo: playStackView.centerXAnchor).isActive = true
        
        
        // add btn
        view.addSubview(changeButton)
        
        // locate btn
        changeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        changeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        // set action to btn
        changeButton.addTarget(self, action: #selector(didTapDiceRoll), for: .touchUpInside)
        
    }
    
    // press button
    @objc func didTapDiceRoll(){
        let first = diceImage.randomElement() ?? "one"
        let second = diceImage.randomElement() ?? "one"
        diceImageView.image = UIImage(named: first)
        diceImageView2.image = UIImage(named: second)
        
        if first == second {
            lblDouble.text = "Double!!"
        }
        else{
            lblDouble.text = "Not Double"
        }
    }
    
}
