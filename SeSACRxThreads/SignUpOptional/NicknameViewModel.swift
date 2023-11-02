//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by 황인호 on 11/3/23.
//

import Foundation
import RxSwift

class NicknameViewModel {
    
    let disposeBag = DisposeBag()
    
    let buttonHidden = BehaviorSubject(value: false)
    
    
    func textCount(text: String) -> Bool {
        if text.count < 2 || text.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    
}
