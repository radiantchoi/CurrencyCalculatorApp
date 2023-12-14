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
        
        label.font = .systemFont(ofSize: 48)
        label.text = "환율 계산"
        return label
    }()
    
    private lazy var sectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .trailing
        return stackView
    }()
    
    private lazy var dateSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "조회시간 : "
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewModel = CurrencyViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindComponents()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(sectionStackView)
        sectionStackView.addArrangedSubview(dateSectionLabel)
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(dateLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        
        sectionStackView.topAnchor.constraint(equalTo: contentStackView.topAnchor).isActive = true
        sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sectionStackView.trailingAnchor.constraint(equalTo: contentStackView.leadingAnchor).isActive = true
        
        contentStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        contentStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func bindComponents() {
        viewModel.$timestamp
            .sink {
                self.dateLabel.text = $0
            }
            .store(in: &cancellables)
    }
}

