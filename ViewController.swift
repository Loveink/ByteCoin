//
//  ViewController.swift
//  ByteCoin
//
//  Created by Александра Савчук on 01.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let coinManager = CoinManager()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var bytcoinLabel: UILabel = {
        let label = UILabel()
        label.text = "ByteCoin"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        label.textColor = UIColor(named: "Title Color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coinStackView: UIStackView = {
        let stack = UIStackView()
        stack.layer.cornerRadius = 40
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.backgroundColor = .placeholderText
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        view.backgroundColor = UIColor(named: "Background Color")
        subviews()
        setupConstraints()
    }
    
    private func subviews() {
        view.addSubview(mainStackView)
        view.addSubview(currencyPicker)
        mainStackView.addArrangedSubview(bytcoinLabel)
        mainStackView.addArrangedSubview(coinStackView)
        coinStackView.addArrangedSubview(coinImageView)
        coinStackView.addArrangedSubview(resultLabel)
        coinStackView.addArrangedSubview(currencyLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bytcoinLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            bytcoinLabel.heightAnchor.constraint(equalToConstant: 60),
            bytcoinLabel.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            
            coinStackView.topAnchor.constraint(equalTo: bytcoinLabel.bottomAnchor, constant: 25),
            coinStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            coinStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10),
            coinStackView.heightAnchor.constraint(equalToConstant: 80),
            
            coinImageView.widthAnchor.constraint(equalToConstant: 80),
            coinImageView.heightAnchor.constraint(equalToConstant: 80),
         
            currencyPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            currencyPicker.heightAnchor.constraint(equalToConstant: 216)
        ])
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}
