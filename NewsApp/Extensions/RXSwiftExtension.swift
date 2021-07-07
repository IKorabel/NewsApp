//
//  RXSwiftExtension.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 06.07.2021.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
              // vc.startAnimating()
            } else {
            //   vc.stopAnimating()
            }
        })
    }
    
}
