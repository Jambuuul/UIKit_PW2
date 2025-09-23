//
//  ViewController.swift
//  doabdulovPW2
//
//  Created by Jam on 21.09.2025.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    //MARK: Constants
    private enum Const {
        static let sliderMin: Double = 0
        static let sliederMax: Double = 1
        
        static let redTitle: String = "Red"
        static let greenTitle: String = "Green"
        static let blueTitle: String = "Blue"
        
        static let stackRadius: Double = 20
        static let stackBottom: Double = 40
        static let stackLeading: Double = 20
        
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
        
        static let hexLength: Int = 6
        static let hexPlaceholder: String = "#000000"
        
        static let colorSwitchAnimationDuration: TimeInterval = 1
    }
    
    let sliderStack = UIStackView()
    let hexStack = UIStackView()
    let randomButton = UIButton(type: .system)
    
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
    }
    
    
    //MARK: Change button
    private func configureColorChoiceChangeButton() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.layer.cornerRadius = Const.stackRadius
        view.addSubview(stack)
        let button = UIButton(type: .system)
        button.setTitle("Change Slider", for: .normal)
        button.addTarget(self,
                           action: #selector(changeColorChoice),
                           for: .touchUpInside)
        
        stack.addArrangedSubview(button)
        
        
        stack.pinTop(to: view, Const.colorChangeTop)
        stack.pinCenterX(to: view.centerXAnchor)
        stack.pinLeft(to: view, Const.colorChangeLeading)
        
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
        sliderStack.axis = .vertical
        view.addSubview(sliderStack)
        sliderStack.layer.cornerRadius = Const.stackRadius
        sliderStack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Const.redTitle, min: Const.sliderMin, max: Const.sliederMax)
        let sliderGreen = CustomSlider(title: Const.greenTitle, min: Const.sliderMin, max: Const.sliederMax)
        let sliderBlue = CustomSlider(title: Const.blueTitle, min: Const.sliderMin, max: Const.sliederMax)
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            sliderStack.addArrangedSubview(slider)
        }
        
        sliderStack.pinCenterX(to: view.centerXAnchor)
        sliderStack.pinLeft(to: view.leadingAnchor, Const.stackLeading)
        sliderStack.pinBottom(to: view.bottomAnchor, Const.stackBottom)
        
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            slider.valueChanged = { [weak self] _ in
                self?.view.backgroundColor = UIColor(
                    displayP3Red: CGFloat(sliderRed.slider.value),
                    green: CGFloat(sliderGreen.slider.value),
                    blue: CGFloat(sliderBlue.slider.value),
                    alpha: 1
                )
            }
        }
    }
    

    //MARK: HEX slider
    private func configureHexStack() {
        hexStack.axis = .horizontal
        view.addSubview(hexStack)

        let hexField = UITextField()
        hexField.placeholder = Const.hexPlaceholder
        hexField.backgroundColor = .white
        hexStack.addArrangedSubview(hexField)
        
        hexStack.pinCenterX(to: view.centerXAnchor)
        hexStack.pinLeft(to: view.leadingAnchor, Const.hexLeading)
        hexStack.pinBottom(to: view.bottomAnchor, Const.hexBottom)
        
    
        let hexButton = UIButton()
        hexButton.setImage(UIImage(systemName:"arrow.right.circle.fill"), for: .normal)
        hexStack.addArrangedSubview(hexButton)
        
        hexButton.addTarget(self, action: #selector (sendHexInfo), for: .touchUpInside)
        hexButton.backgroundColor = .green
        hexStack.isHidden = Const.hexHidden
        hexStack.layer.cornerRadius = Const.stackRadius
    }
    
    //MARK: Random button
    private func configureRandomButton() {
        randomButton.setTitle("Random!", for: .normal)
        randomButton.isHidden = Const.randomHidden
        randomButton.backgroundColor = .white
        randomButton.layer.cornerRadius = Const.stackRadius
        view.addSubview(randomButton)
        
        randomButton.pinLeft(to: view.leadingAnchor, Const.stackLeading)
        randomButton.pinCenterX(to: view.centerXAnchor)
        randomButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Const.stackBottom)
        
        randomButton.addTarget(self, action: #selector (randomBackgroundColor), for: .touchUpInside)
    }
    
    
    //MARK: Hex button action
    @objc
    private func sendHexInfo() {
        var value = (hexStack.arrangedSubviews[0] as! UITextField).text ?? Const.hexPlaceholder
        if value.count != Const.hexLength + 1 {
            return;
        }
        value = String(value.suffix(Const.hexLength))
        
        let scanner = Scanner(string: value)
        var num: Int64 = 0
        if scanner.scanHexInt64(&num) {
            
            changeBackgroundColor(to: UIColor.hexToRgb(from: num))
        }
    }
    
    //MARK: change button action
    @objc private func changeColorChoice(sender: UIButton) {
        if !sliderStack.isHidden {
            sliderStack.isHidden = true
            hexStack.isHidden = false
            return
        }
        if !hexStack.isHidden {
            hexStack.isHidden = true
            randomButton.isHidden = false
            return
        }
        randomButton.isHidden = true
        sliderStack.isHidden = false
        
    }

    //MARK: random button action
    @objc
    private func randomBackgroundColor() {
        changeBackgroundColor(to: .random)
    }
    
    //MARK: для чистоты кода
    private func changeBackgroundColor(to color: UIColor) {
        UIView.animate(withDuration: Const.colorSwitchAnimationDuration) {
            self.view.backgroundColor = color
        }
    }
    
}
