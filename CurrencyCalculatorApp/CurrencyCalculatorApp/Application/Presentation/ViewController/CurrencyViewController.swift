//
//  CurrencyViewController.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/13/23.
//

import Combine
import UIKit

final class CurrencyViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: CGFloat.CurrencyViewControllerValues.titleLabelFontSize)
        label.text = String.CurrencyViewControllerValues.titleLabelText
        return label
    }()
    
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

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 18)
        label.text = String.CurrencyViewControllerValues.resultLabelPlaceholderText
        return label
    }()
    
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
    
    private func setupActions() {
        moneyInputTextField.addTarget(self, action: #selector(moneyInputTextFieldDidChanged), for: .editingChanged)
        selectCountryButton.addTarget(self, action: #selector(selectCountryButtonTapped), for: .touchUpInside)
    }
    
    private func bindComponents() {
        viewModel.$timestamp
            .sink { [weak self] timestamp in
                self?.dateLabel.text = timestamp
            }
            .store(in: &cancellables)
        
        viewModel.$selectedCountry
            .sink { [weak self] country in
                self?.receivingCountryLabel.text = "\(country.rawValue) (\(country.currency))"
            }
            .store(in: &cancellables)
        
        viewModel.$selectedCurrency
            .sink { [weak self] rate in
                self?.currencyLabel.text = String(rate)
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
    
    @objc func moneyInputTextFieldDidChanged() {
        guard let number = viewModel.verifyInputValue(moneyInputTextField.text) else {
            resultLabel.text = String.CurrencyViewControllerValues.invalidTransactionText
            resultLabel.textColor = .red
            return
        }
        
        viewModel.changeMoneyValue(number)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
