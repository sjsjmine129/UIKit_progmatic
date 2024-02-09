//
//  SRPViewController.swift
//  UIKit_progmatic
//
//  Created by 엄승주 on 2/8/24.
//

import UIKit
import SwiftUI

enum InputState: String{
    case scissors
    case rock
    case paper
}

enum GameResult: String{
    case win = "Win!"
    case draw = "Draw!"
    case lose = "Lose!"
}

class SRPViewController: UIViewController {
    
    let imageData: [InputState] = [.paper, .rock, .scissors]
    
    lazy var playStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .lightGray
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var computerGameImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rock"))
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    lazy var myGameImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rock"))
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    lazy var lblResult : UILabel = {
        let lbl = UILabel()
        lbl.text = "Start game"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    lazy var lblCom : UILabel = {
        let lbl = UILabel()
        lbl.text = "Computer"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    lazy var lblPlayer : UILabel = {
        let lbl = UILabel()
        lbl.text = "player"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    lazy var btnScissors: GameButton = {
        let button = GameButton()
        button.translatesAutoresizingMaskIntoConstraints = false // use auto layout
        button.setTitle("Scissors", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var btnRock: GameButton = {
        let button = GameButton()
        button.translatesAutoresizingMaskIntoConstraints = false // use auto layout
        button.setTitle("Rock", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var btnPaper: GameButton = {
        let button = GameButton()
        button.translatesAutoresizingMaskIntoConstraints = false // use auto layout
        button.setTitle("Paper", for: .normal)
        button.backgroundColor = .magenta
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // add stack
        view.addSubview(playStackView)
        // add constraint
        playStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        playStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        playStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        playStackView.addArrangedSubview(computerGameImageView)
        playStackView.addArrangedSubview(myGameImageView)
        
        // add com lbl
        view.addSubview(lblCom)
        // add constraint
        lblCom.bottomAnchor.constraint(equalTo: playStackView.topAnchor, constant: -10).isActive = true
        lblCom.centerXAnchor.constraint(equalTo: computerGameImageView.centerXAnchor).isActive = true
        
        // add player lbl
        view.addSubview(lblPlayer)
        // add constraint
        lblPlayer.bottomAnchor.constraint(equalTo: playStackView.topAnchor, constant: -10).isActive = true
        lblPlayer.centerXAnchor.constraint(equalTo: myGameImageView.centerXAnchor).isActive = true
        
        
        // add result lbl
        view.addSubview(lblResult)
        // add constraint
        lblResult.topAnchor.constraint(equalTo: playStackView.bottomAnchor, constant: 20).isActive = true
        lblResult.centerXAnchor.constraint(equalTo: playStackView.centerXAnchor).isActive = true
        
        
        // add button stack
        view.addSubview(inputStackView)
        // add constraint
        inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        inputStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        inputStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputStackView.addArrangedSubview(btnScissors)
        btnScissors.gameTag = .scissors //set tag
        inputStackView.addArrangedSubview(btnRock)
        btnRock.gameTag = .rock
        inputStackView.addArrangedSubview(btnPaper)
        btnPaper.gameTag = .paper
        
        btnScissors.addTarget(self, action: #selector(btnPress), for: .touchUpInside)
        btnPaper.addTarget(self, action: #selector(btnPress), for: .touchUpInside)
        btnRock.addTarget(self, action: #selector(btnPress), for: .touchUpInside)
    }
    
    // press button
    @objc func btnPress(_ sender: UIButton){
        guard let sender = sender as? GameButton else {return}
        
        switch sender.gameTag{
        case .scissors:
            myGameImageView.image = UIImage(named: "scissors")
        case .rock:
            myGameImageView.image = UIImage(named: "rock")
        case .paper:
            myGameImageView.image = UIImage(named: "paper")
        }
        
        
        let rand = imageData.randomElement()!
        computerGameImageView.image=UIImage(named: rand.rawValue)
        
        //check win or not
        lblResult.text =  fetchGameResult(comInput: rand, myInput: sender.gameTag).rawValue
    }
    
    
    private func fetchGameResult(comInput : InputState, myInput: InputState)->GameResult{
        switch (myInput, comInput) {
        case (.scissors, .scissors): return .draw
        case (.scissors, .rock): return .lose
        case (.scissors, .paper): return .win
        case (.rock, .scissors): return .win
        case (.rock, .rock): return .draw
        case (.rock, .paper): return .win
        case (.paper, .scissors): return .lose
        case (.paper, .rock): return .win
        case (.paper, .paper): return .draw
        }
    }
    
    
}

class GameButton: UIButton{
    var gameTag: InputState = .rock
}


//
struct PreView: PreviewProvider {
    static var previews: some View {
        SRPViewController().toPreview()
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
