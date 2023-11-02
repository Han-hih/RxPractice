//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 황인호 on 11/2/23.
//

import Foundation
import RxSwift

class BirthdayViewModel {
    
    let disposeBag = DisposeBag()
    
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    let year = BehaviorSubject(value: 2020)
    let month = BehaviorSubject(value: 12)
    let day = BehaviorSubject(value: 21)
    let buttonEnabled = BehaviorSubject(value: false)
    
   
    
    func yearFormatter(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: Date()).year!
    }
    func monthFormatter(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: Date()).month!
    }
    func dayFormatter(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day!
    }
    
    
}
