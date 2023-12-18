//
//  CurrencyViewController.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/13/23.
//

import Combine
import UIKit

final class CurrencyViewController: UIViewController {
    /// 전체 뷰 제목 레이블입니다.
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: CGFloat.CurrencyViewControllerValues.titleLabelFontSize)
        label.text = String.CurrencyViewControllerValues.titleLabelText
        return label
    }()
    
    /// 좌측의 섹션 제목들을 묶는 스택 뷰입니다.
    private lazy var sectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = CGFloat.CurrencyViewControllerValues.stackViewVerticalSpacing
        return stackView
    }()
    
    private lazy var sendingSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.sendingSectionLabelText
        return label
    }()
    
    private lazy var receivingSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.receivingSectionLabelText
        return label
    }()
    
    private lazy var currencySectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.currencySectionLabelText
        return label
    }()
    
    private lazy var dateSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.dateSectionLabelText
        return label
    }()
    
    private lazy var moneySectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.moneySectionLabelText
        return label
    }()
    
    /// 실제 표시되는 값들을 묶는 스택 뷰입니다.
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = CGFloat.CurrencyViewControllerValues.stackViewVerticalSpacing
        return stackView
    }()
    
    private lazy var sendingCountryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.sendingLabelText
        return label
    }()
    
    private lazy var receivingCountryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.placeholderValue
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    /// 사용자 송금 란에서 텍스트 필드와 기준 화폐 레이블을 묶는 스택 뷰입니다.
    private lazy var moneyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = CGFloat.CurrencyViewControllerValues.stackViewHorizontalSpacing
        return stackView
    }()
    
    private lazy var moneyInputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addDoneCancelToolbar()
        textField.borderStyle = .line
        textField.keyboardType = .decimalPad
        textField.textAlignment = .right
        return textField
    }()
    
    private lazy var moneyUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = String.CurrencyViewControllerValues.moneyUnitLabelText
        return label
    }()
    
    /// 송금 예정 금액을 표시하는 레이블입니다.
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 18)
        label.text = String.CurrencyViewControllerValues.resultLabelPlaceholderText
        return label
    }()
    
    /// 국가 선택 액션 시트를 불러 오는 버튼입니다.
    private lazy var selectCountryButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(String.CurrencyViewControllerValues.selectCountryButtonTitle, for: .normal)
        return button
    }()
    
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    private let viewModel = CurrencyViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindComponents()
        setupActions()
    }
    
    /// 뷰에 컴포넌트들을 추가하는 레이블입니다.
    /// 화면의 전체적 구성을 모두 수행합니다.
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(sectionStackView)
        view.addSubview(contentStackView)
        view.addSubview(resultLabel)
        view.addSubview(selectCountryButton)
        
        sectionStackView.addArrangedSubview(sendingSectionLabel)
        sectionStackView.addArrangedSubview(receivingSectionLabel)
        sectionStackView.addArrangedSubview(currencySectionLabel)
        sectionStackView.addArrangedSubview(dateSectionLabel)
        sectionStackView.addArrangedSubview(moneySectionLabel)
        
        contentStackView.addArrangedSubview(sendingCountryLabel)
        contentStackView.addArrangedSubview(receivingCountryLabel)
        contentStackView.addArrangedSubview(currencyLabel)
        contentStackView.addArrangedSubview(dateLabel)
        contentStackView.addArrangedSubview(moneyStackView)
        
        moneyStackView.addArrangedSubview(moneyInputTextField)
        moneyStackView.addArrangedSubview(moneyUnitLabel)
        
        view.addGestureRecognizer(tapRecognizer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat.CurrencyViewControllerValues.titleLabelTopConstant).isActive = true
        
        sectionStackView.topAnchor.constraint(equalTo: contentStackView.topAnchor).isActive = true
        sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sectionStackView.trailingAnchor.constraint(equalTo: contentStackView.leadingAnchor).isActive = true
        
        contentStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat.CurrencyViewControllerValues.titleLabelBottomConstant).isActive = true
        contentStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat.CurrencyViewControllerValues.contentStackViewRatio).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        moneyStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor).isActive = true
        moneyStackView.heightAnchor.constraint(equalToConstant: CGFloat.CurrencyViewControllerValues.moneyInputTextFieldHeight).isActive = true
        moneyInputTextField.widthAnchor.constraint(equalTo: moneyStackView.widthAnchor, multiplier: CGFloat.CurrencyViewControllerValues.moneyInputTextFieldRatio).isActive = true
        moneyInputTextField.heightAnchor.constraint(equalToConstant: CGFloat.CurrencyViewControllerValues.moneyInputTextFieldHeight).isActive = true
        
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: sectionStackView.bottomAnchor, constant: CGFloat.CurrencyViewControllerValues.resultLabelTopConstant).isActive = true
        
        selectCountryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectCountryButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: CGFloat.CurrencyViewControllerValues.selectCountryButtonTopConstant).isActive = true
    }
    
    /// 뷰 모델의 Published 프로퍼티와 뷰 요소를 바인딩합니다.
    private func bindComponents() {
        viewModel.$timestamp
            .sink { [weak self] timestamp in
                self?.dateLabel.text = timestamp
            }
            .store(in: &cancellables)
        
        viewModel.$selectedCountry
            .sink { [weak self] country in
                self?.receivingCountryLabel.text = "\(country.rawValue) (\(country.currencyName))"
            }
            .store(in: &cancellables)
        
        viewModel.$selectedCurrency
            .sink { [weak self] selection in
                self?.currencyLabel.text = String.CurrencyViewControllerValues.currencyLabelText(selection)
            }
            .store(in: &cancellables)
        
        viewModel.$sendingMoney
            .sink { [weak self] money in
                self?.resultLabel.text = String.CurrencyViewControllerValues.resultLabelText(money)
                self?.resultLabel.textColor = .black
            }
            .store(in: &cancellables)
        
        viewModel.$fetchingError
            .sink { [weak self] error in
                if let error {
                    self?.makeOKAlert(title: String.CurrencyViewControllerValues.errorTitle, message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
    
    /// target-action 방식의 액션들을 설정합니다.
    private func setupActions() {
        moneyInputTextField.addTarget(self, action: #selector(moneyInputTextFieldDidChanged), for: .editingChanged)
        selectCountryButton.addTarget(self, action: #selector(selectCountryButtonTapped), for: .touchUpInside)
    }
    
    /// 국가 선택 버튼이 탭되었을 경우, 국가를 선택할 수 있는 액션 시트를 Present합니다.
    @objc func selectCountryButtonTapped() {
        let actionSheet = UIAlertController(title: String.CurrencyViewControllerValues.selectCountrySheetTitle, message: nil, preferredStyle: .actionSheet)
        let actions = Country.allCases.map { country in
            UIAlertAction(title: country.rawValue, style: .default) { [weak self] _ in self?.viewModel.selectCountry(country) }
        }
        let cancel = UIAlertAction(title: String.CurrencyViewControllerValues.cancelSheetText, style: .cancel, handler: nil)

        actions.forEach { actionSheet.addAction($0) }
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    /// 텍스트 필드의 값이 바뀔 때마다, 해당 입력값을 검증하고 계산하여 레이블에 반영합니다.
    @objc func moneyInputTextFieldDidChanged() {
        guard let number = viewModel.verifyInputValue(moneyInputTextField.text) else {
            resultLabel.text = String.CurrencyViewControllerValues.invalidTransactionText
            resultLabel.textColor = .red
            return
        }
        
        viewModel.changeMoneyValue(number)
    }
    
    /// 키보드 바깥의 영역을 탭했을 경우, 키보드가 내려가게 합니다.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
