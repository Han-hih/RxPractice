//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BirthdayViewController: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    lazy var nextButton = PointButton(title: "가입하기")
    let disposeBag = DisposeBag()
    
    let viewModel = BirthdayViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func bind() {
        birthDayPicker.rx.date
            .bind(to: viewModel.birthday)
            .disposed(by: disposeBag)
        
        viewModel.buttonEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.birthday
            .subscribe(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                
                owner.viewModel.year.onNext(component.year!)
                owner.viewModel.month.onNext(component.month!)
                owner.viewModel.day.onNext(component.day!)
                
                print(component.year!, component.month!, component.day!)
            }
            .disposed(by: disposeBag)
        
        viewModel.birthday.map { date in
            let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
            if self.viewModel.yearFormatter(from: date) > 17 {
                return true
            } else if self.viewModel.yearFormatter(from: date) == 17 && self.viewModel.monthFormatter(from: date) == component.month! && self.viewModel.dayFormatter(from: date) >= component.day! {
                return true
            } else if self.viewModel.yearFormatter(from: date) == 17 && self.viewModel.monthFormatter(from: date) > component.month! {
                return true
            } else {
                return false
            }
        }
        .subscribe(with: self) { owner, value in
            let isEnable = value ? true : false
            self.viewModel.buttonEnabled.onNext(isEnable)
        }
        .disposed(by: disposeBag)
        
        
        viewModel.year.map { "\($0)년" }
            .subscribe(with: self) { owner, value in
                owner.yearLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.month.map { "\($0)월" }
            .subscribe(with: self) { owner, value in
                owner.monthLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.day.map { "\($0)일" }
            .subscribe(with: self) { owner, value in
                owner.dayLabel.text = value
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        print("가입완료")
    }
    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
}
