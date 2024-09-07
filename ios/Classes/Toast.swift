//
//  Toast.swift
//  tencent_cloud_uikit_core
//
//  Created by vincepzhang on 2024/4/17.
//

import UIKit

class Toast {
    static func show(message: String, duration: TimeInterval, position: ToastPosition) {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        toastLabel.textColor = .white
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5
        toastLabel.clipsToBounds = true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(toastLabel)
        
        let horizontalConstraint: NSLayoutConstraint
        switch position {
        case .top:
            horizontalConstraint = toastLabel.topAnchor.constraint(equalTo: window.topAnchor, constant: 100)
        case .center:
            horizontalConstraint = toastLabel.centerYAnchor.constraint(equalTo: window.centerYAnchor)
        case .bottom:
            horizontalConstraint = toastLabel.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -100)
        }
        
        NSLayoutConstraint.activate([
            toastLabel.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            toastLabel.widthAnchor.constraint(lessThanOrEqualTo: window.widthAnchor, multiplier: 0.8),
            horizontalConstraint
        ])
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}

enum ToastPosition {
    case top
    case center
    case bottom
}
