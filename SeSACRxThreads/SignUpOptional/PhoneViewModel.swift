//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by 황인호 on 11/3/23.
//

import Foundation
import RxSwift

class PhoneViewModel {
    
    let disposeBag = DisposeBag()
    
    let phone = BehaviorSubject(value: "010")
    let buttonColor = BehaviorSubject(value: Color.red)
    let buttonEnabled = BehaviorSubject(value: false)
    
}




    extension String {
        var decimalFilteredString: String {
            return String(unicodeScalars.filter(CharacterSet.decimalDigits.contains))
        }
        
    func formatted(by patternString: String) -> String {
        let digit: Character = "#"
        
        let pattern: [Character] = Array(patternString)
        let input: [Character] = Array(self.decimalFilteredString)
        var formatted: [Character] = []
        
        var patternIndex = 0
        var inputIndex = 0
        
        // 2
        while inputIndex < input.count {
            let inputCharacter = input[inputIndex]
            
            // 2-1
            guard patternIndex < pattern.count else { break }
            
            switch pattern[patternIndex] == digit {
            case true:
                // 2-2
                formatted.append(inputCharacter)
                inputIndex += 1
            case false:
                // 2-3
                formatted.append(pattern[patternIndex])
            }
            
            patternIndex += 1
        }
        
        // 3
        return String(formatted)
    }

}


