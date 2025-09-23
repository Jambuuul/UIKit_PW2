//
//  ViewController.swift
//  doabdulovPW2
//
//  Created by Jam on 21.09.2025.
//

import UIKit

final class WishMakerViewController: UIViewController {

    var sliderStack: UIStackView!
    var hexSlider: CustomSlider!
    
    
    private enum Const {
        static let sliderMin: Double = 0
        static let sliederMax: Double = 1
        
        static let redTitle: String = "Red"
        static let greenTitle: String = "Green"
        static let blueTitle: String = "Blue"
        
        static let stackRadius: Double = 20
        static let stackBottom: Double = 40
        static let stackLeading: Double = 20
        
        static let descConstraint: Double = 100
        
        static let titleTop: Double = 30
        
        static let descFontSize: Double = 16
        static let titleFontSize: Double = 32
        
        static let hexBottom: Double = 150
        static let hexLeading: Double = 20
        static let hexRadius: Double = 20
        static let hexMin: Double = 0
        static let hexMax: Double = 0xFFFFFF
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray
        
        
        configureTitle()
        configureDesctiption()
        configureRgbSliders()
        ConfigureSliderChangingButton()
        configureHexSlider()
    }
    
    @objc private func changeSlider(sender: UIButton) {
        sliderStack.isHidden.toggle()
        hexSlider.isHidden.toggle()
    }
    
//    @objc private func showHexSlider(sender: UIButton) {
//        sliderStack.isHidden = false
//        hexSlider.isHidden = true
//    }
    
    
    private func ConfigureSliderChangingButton() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 20
        view.addSubview(stack)
        let button1 = UIButton(type: .system)
        button1.setTitle("Change Slider", for: .normal)
        button1.addTarget(self,
                           action: #selector(changeSlider),
                           for: .touchUpInside)
        
        stack.addArrangedSubview(button1)
        
        
        stack.pinTop(to: view, 300)
        stack.pinCenterX(to: view.centerXAnchor)
        stack.pinLeft(to: view, 100)
        
    }
    
    private func configureTitle() {
        let title = UILabel()
        title.text = "Wishmaker"
        title.font = UIFont.boldSystemFont(ofSize: Const.titleFontSize)
        title.textColor = UIColor.random

        view.addSubview(title)
        
        
        title.pinCenterX(to: view.centerXAnchor)
        title.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Const.titleTop)
    }
    
    
    private func configureDesctiption() {
        let desc = UILabel()
        desc.text = "Hello! This app is here to grant you a wish! Choose wisely, my friend..."
        
        
        desc.font = UIFont.systemFont(ofSize: Const.descFontSize)
        desc.numberOfLines = 5
        desc.textColor = .white
        view.addSubview(desc)
        desc.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Const.descConstraint)
        desc.pinCenterX(to: view.centerXAnchor)
        desc.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Const.descConstraint)
        desc.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, Const.descConstraint)
    }
    
    
    private func configureRgbSliders() {
        sliderStack = UIStackView()
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
            slider.valueChanged = { [weak self] value in
                self?.view.backgroundColor = UIColor(
                    displayP3Red: CGFloat(sliderRed.slider.value),
                    green: CGFloat(sliderGreen.slider.value),
                    blue: CGFloat(sliderBlue.slider.value),
                    alpha: 1
                )
            }
        }
    }
    

    private func configureHexSlider() {
        hexSlider = CustomSlider(title: "Hex Slider", min: Const.hexMin, max: Const.hexMax)
        hexSlider.isHidden = true
        hexSlider.layer.cornerRadius = Const.hexRadius
        
        view.addSubview(hexSlider)
        hexSlider.pinCenterX(to: view.centerXAnchor)
        hexSlider.pinLeft(to: view.leadingAnchor, Const.hexLeading)
        hexSlider.pinBottom(to: view.bottomAnchor, Const.hexBottom)
    
        
        hexSlider.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor.hexToRgb(from: Int(self?.hexSlider.slider.value ?? 0))
        }
    }
}
