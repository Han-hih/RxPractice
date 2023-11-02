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
    
    init() {
        birthday
            .subscribe(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                owner.year.onNext(component.year!)
                owner.month.onNext(component.month!)
                owner.day.onNext(component.day!)
                
            } onDisposed: { owner in
                print("birthday dispose")
            }
            .disposed(by: disposeBag)
            }
    
    
    func ageCalculate(date: Date) -> Bool {
        let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
            if self.yearFormatter(from: date) > 17 {
                return true
            } else if self.yearFormatter(from: date) == 17 && self.monthFormatter(from: date) == component.month! && self.dayFormatter(from: date) >= component.day! {
                return true
            } else if self.yearFormatter(from: date) == 17 && self.monthFormatter(from: date) > component.month! {
                return true
            } else {
                return false
            }
        }
    
    
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
