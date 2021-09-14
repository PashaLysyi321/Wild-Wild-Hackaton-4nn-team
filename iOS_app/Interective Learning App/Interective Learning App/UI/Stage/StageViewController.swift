//
//  StageViewController.swift
//  Interective Learning App
//
//  Created by Prefect on 12.09.2021.
//

import UIKit

class StageViewController: UIViewController {
    
    //MARK: - View
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var chooseStageButton: UIButton!
    
    //MARK: - Variables
    private var stages = Environment.allCases
    private var coordinator: StageCoordinator?
    
    //MARK: - VC cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        setup()
    }
    
    func configure(_ coordinator: StageCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Setup
extension StageViewController {
    
    func setup() {
        navigationController?.isNavigationBarHidden = true
        layout()
    }
    
    func layout() {
        // Configure chooseStageButton
        chooseStageButton.backgroundColor = R.color.lightYellow()
        chooseStageButton.layer.borderColor = UIColor.white.cgColor
        chooseStageButton.layer.borderWidth = 1
        chooseStageButton.layer.cornerRadius = 15
        chooseStageButton.setTitleColor(.white, for: .normal)
        chooseStageButton.setTitle("Go", for: .normal)
    }
}

// MARK: - Actions
extension StageViewController {
    
    @IBAction func chooseStageButtonTapped(_ sender: UIButton) {
        coordinator?.showHomeFlow()
    }
}

// MARK: - UIPickerViewDelegate
extension StageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        stages[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Constants.currentEnviroment = stages[row]
    }
}

