//
//  CustomSlider.swift
//  doabdulovPW2
//
//  Created by Jam on 22.09.2025.
//

import UIKit


private enum SliderConstraints {
    static let titleTop: CGFloat = 10
    static let titleLeading: CGFloat = 20
    
    static let sliderLeading: CGFloat = 20
    static let sliderBottom: CGFloat = 10
}

final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView  = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(slider)
        addSubview(titleView)
        
        titleView.pinCenterX(to: centerXAnchor)
        titleView.pinTop(to: topAnchor, SliderConstraints.titleTop)
        titleView.pinLeft(to: leadingAnchor, SliderConstraints.titleLeading)
        
        slider.pinTop(to:titleView.bottomAnchor)
        slider.pinCenterX(to:centerXAnchor)
        slider.pinBottom(to:bottomAnchor, SliderConstraints.sliderBottom)
        slider.pinLeft(to:leadingAnchor, SliderConstraints.sliderLeading)
    }
    
    public var value: CGFloat {
        get {
            return CGFloat(slider.value)
        }
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
    
    
}
