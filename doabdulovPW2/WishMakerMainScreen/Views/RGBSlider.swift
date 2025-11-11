//
//  RGBSlider.swift
//  doabdulovPW2
//
//  Created by Jam on 10.11.2025.
//

import UIKit

final class RGBSlider: UIView {
    private enum Const {
        static let redSliderTitle: String = "Red"
        static let greenSliderTitle: String = "Green"
        static let blueSliderTitle: String = "Blue"
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let stackRadius: Double = 20
    }
    
    private let stack = UIStackView()
    
    public var onColorChange: ((UIColor) -> Void)?
    
    public let redSlider = CustomSlider(
        title: Const.redSliderTitle,
        min: Const.sliderMin,
        max: Const.sliderMax
    )
    
    public let greenSlider = CustomSlider(
        title: Const.greenSliderTitle,
        min: Const.sliderMin,
        max: Const.sliderMax
    )
    
    public let blueSlider = CustomSlider(
        title: Const.blueSliderTitle,
        min: Const.sliderMin,
        max: Const.sliderMax
    )
    
    public func GetCurrentColor() -> UIColor {
        return UIColor(
            displayP3Red: redSlider.value,
            green: greenSlider.value,
            blue: blueSlider.value,
            alpha: 1)
    }
    

    init() {
        super.init(frame: .zero)
        configureUI()
        valuesChanged()
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        stack.axis = .vertical
        stack.backgroundColor = .white
        self.layer.cornerRadius = Const.stackRadius
        stack.layer.cornerRadius = Const.stackRadius
        stack.clipsToBounds = true
        addSubview(stack)
        
        
        stack.pinCenterX(to: centerXAnchor)
        stack.pinTop(to: topAnchor)
        stack.pinLeft(to: leadingAnchor)
        stack.pinBottom(to: bottomAnchor)
        
        for slider in [redSlider, greenSlider, blueSlider] {
            stack.addArrangedSubview(slider)
        }
    }
    
    private func valuesChanged() {
        for slider in [redSlider, greenSlider, blueSlider] {
            slider.valueChanged = { [weak self] _ in
                guard let self else { return }
                self.onColorChange?(self.GetCurrentColor())
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
