//
//  CustomTabBar.swift
//  WeatherTestProject_Final
//
//  Created by Андрей Федоров on 28.04.2023.
//

import Foundation
import UIKit

final class CustomTabBar: UITabBar{
   
    
    init(){
        super.init(frame: .zero)
        print("First")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.bounds.contains(point) {
            print("wow")
            let correctedPoint = CGPoint(x: point.x, y: self.bounds.size.height - point.y)
            return super.point(inside: correctedPoint, with: event)
        }
        return false
    }
    
    
}
