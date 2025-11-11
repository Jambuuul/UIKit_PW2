//
//  ViewController.swift
//  doabdulovPW2
//
//  Created by Jam on 21.09.2025.
//

import UIKit

final class WishMakerViewController: UIViewController {
    typealias Model = WishMakerModel
    
    //MARK: Constants
    private enum Const {
        static let sliderMin: Double = 0
        static let sliederMax: Double = 1
        
        static let redTitle: String = "Red"
        static let greenTitle: String = "Green"
        static let blueTitle: String = "Blue"
        
        static let slidersRadius: Double = 20
        static let slidersBottom: Double = 40
        static let slidersLeading: Double = 20
        
        static let colorChangeTop: Double = 300
        static let colorChangeLeading: Double = 100
        
        static let descConstraint: Double = 100
        
        static let titleTop: Double = 30
        
        static let descFontSize: Double = 16
        static let titleFontSize: Double = 32
        
        static let descNumberOfLines: Int = 5
        
        static let hexBottom: Double = 150
        static let hexLeading: Double = 30
        static let hexRadius: Double = 20
        static let hexMin: Double = 0
        static let hexMax: Double = 0xFFFFFF
        
        static let sliderHidden: Bool = false
        static let hexHidden: Bool = true
        static let randomHidden: Bool = true
        
        static let hexPlaceholder: String = "#000000"
        
        static let colorSwitchAnimationDuration: TimeInterval = 1
        
        
        static let buttonHeight: Double = 40
        static let buttonTop: Double = 20
        static let buttonSide: Double = 100
    }
    
    let sliders: RGBSlider = RGBSlider()
    let randomButton: UIButton = UIButton(type: .system)
    let hexTextField: CustomTextField = CustomTextField()
    let addWishButton: UIButton = UIButton(type: .system)
    let colorChoiceChangeButton: UIButton = UIButton(type: .system)
    
    private let interactor: WishMakerBusinessLogic
    
    // MARK: - LifeCycle
    init(
        interactor: WishMakerBusinessLogic
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("no")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        view.backgroundColor = .black
        
        configureTitle()
        configureDesctiption()
        configureRgbSliders()
        configureColorChoiceChangeButton()
        configureHexStack()
        configureRandomButton()
        configureAddWishButton()
    }
    
    
    //MARK: Change button
    private func configureColorChoiceChangeButton() {

        view.addSubview(colorChoiceChangeButton)

        colorChoiceChangeButton.setTitle("Change Slider", for: .normal)
        colorChoiceChangeButton.addTarget(self,
                           action: #selector(changeColorChoice),
                           for: .touchUpInside)
        
        colorChoiceChangeButton.layer.cornerRadius = 15

        colorChoiceChangeButton.setHeight(Const.buttonHeight)
        colorChoiceChangeButton.backgroundColor = .green
        colorChoiceChangeButton.pinTop(to: view, Const.colorChangeTop)
        colorChoiceChangeButton.pinCenterX(to: view.centerXAnchor)
        colorChoiceChangeButton.pinLeft(to: view, Const.colorChangeLeading)
        
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
    
        addWishButton.setHeight(Const.buttonHeight)
        addWishButton.pinTop(to: colorChoiceChangeButton.bottomAnchor, Const.buttonTop)
        addWishButton.pinHorizontal(to: view, Const.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitle("Add Wish", for: .normal)
        
        
        addWishButton.layer.cornerRadius = 15
        addWishButton.addTarget(self,
                                action: #selector(addWishButtonPressed),
                                for: .touchUpInside
                                )
                                
    }
    
    //MARK: Title
    private func configureTitle() {
        let title = UILabel()
        title.text = "Wishmaker"
        title.font = UIFont.boldSystemFont(ofSize: Const.titleFontSize)
        title.textColor = UIColor.random

        view.addSubview(title)
        
        
        title.pinCenterX(to: view.centerXAnchor)
        title.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Const.titleTop)
    }
    
    
    //MARK: Description
    private func configureDesctiption() {
        let desc = UILabel()
        desc.text = "Hello! This app is here to grant you a wish! Choose wisely, my friend..."
        
        
        desc.font = UIFont.systemFont(ofSize: Const.descFontSize)
        desc.numberOfLines = Const.descNumberOfLines
        desc.textColor = .white
        view.addSubview(desc)
        
        desc.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Const.descConstraint)
        desc.pinCenterX(to: view.centerXAnchor)
        desc.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Const.descConstraint)
        desc.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, Const.descConstraint)
    }
    
    //MARK: RGB sliders
    private func configureRgbSliders() {
        view.addSubview(sliders)
        
        sliders.pinCenterX(to: view.centerXAnchor)
        sliders.pinLeft(to: view.leadingAnchor, Const.slidersLeading)
        sliders.pinBottom(to: view.bottomAnchor, Const.slidersBottom)
        
        sliders.onColorChange = { [weak self] color in
                self?.view.backgroundColor = color
        }
    }
    

    //MARK: HEX slider
    private func configureHexStack() {
        hexTextField.placeholder = "#000000"
        
        hexTextField.isHidden = Const.hexHidden
        
        
        hexTextField.sendButton.addTarget(self, action: #selector (sendHexInfo), for: .touchUpInside)
        
        view.addSubview(hexTextField)
        
        hexTextField.pinCenterX(to: view.centerXAnchor)
        hexTextField.pinLeft(to: view.leadingAnchor, Const.hexLeading)
        hexTextField.pinBottom(to: view.bottomAnchor, Const.hexBottom)
    }
    
    //MARK: Random button
    private func configureRandomButton() {
        randomButton.setTitle("Random!", for: .normal)
        randomButton.isHidden = Const.randomHidden
        randomButton.backgroundColor = .white
        randomButton.layer.cornerRadius = Const.slidersRadius
        view.addSubview(randomButton)
        
        randomButton.pinLeft(to: view.leadingAnchor, Const.slidersLeading)
        randomButton.pinCenterX(to: view.centerXAnchor)
        randomButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Const.slidersBottom)
        
        randomButton.addTarget(self, action: #selector (randomBackgroundColor), for: .touchUpInside)
    }
    
    
    //MARK: Hex button action
    @objc
    private func sendHexInfo() {
        let value = (hexTextField.textField).text ?? Const.hexPlaceholder
        
        // вызов интерактора
        interactor.getColorFromHex(Model.HexColorUpdate.Request(hex: value))
    }
    
    //MARK: change button action
    @objc private func changeColorChoice(sender: UIButton) {
        if !sliders.isHidden {
            sliders.isHidden = true
            hexTextField.isHidden = false
            return
        }
        if !hexTextField.isHidden {
            hexTextField.isHidden = true
            randomButton.isHidden = false
            return
        }
        randomButton.isHidden = true
        sliders.isHidden = false
        
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }

    //MARK: random button action
    @objc
    private func randomBackgroundColor() {
        interactor.getRandomColor()
    }
    
    //MARK: для чистоты кода
    public func changeBackgroundColor(to color: UIColor) {
        UIView.animate(withDuration: Const.colorSwitchAnimationDuration) {
            self.view.backgroundColor = color
        }
    }
    
    
}
