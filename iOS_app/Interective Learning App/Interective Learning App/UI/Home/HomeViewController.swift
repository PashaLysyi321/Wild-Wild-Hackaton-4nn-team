//
//  HomeViewControler.swift
//  Interective Learning App
//
//  Created by Prefect on 10.09.2021.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    // MARK: - View
    private var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sairaSemiCondensedMedium(size: 26)
        label.textColor = .black
        label.text = "Input"
        label.textAlignment = .left
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = R.font.sairaSemiCondensedMedium(size: 24)
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    private var controlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    var customizeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.lightYellow()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Customize", for: .normal)
        return button
    }()
    
    private var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.lightGreen()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    // Activity control
    private var activityControl: UIActivityIndicatorView = {
        let activityControl = UIActivityIndicatorView()
        activityControl.color = .black
        activityControl.style = .large
        activityControl.startAnimating()
        return activityControl
    }()
    
    private var activityControlBackgroundView: UIView = {
        let view = UIView()
        view.alpha = 0.7
        view.backgroundColor = R.color.lightGrey()
        return view
    }()
    
    // MARK: - Variables
    private var coordinator: HomeCoordinator?
    
    // MARK: - VC cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation bar
        navigationController?.isNavigationBarHidden = true
        activityControl(hide: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
    }
    
    func addTargets() {
        customizeButton.addTarget(self, action: #selector(customizeButtonTap), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonTap), for: .touchUpInside)
    }
    
    func configure(_ coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc func customizeButtonTap() {
        self.coordinator?.startCustomizeFlow()
    }
    
    @objc func searchButtonTap() {
        activityControl(hide: false)
        guard let text = textView.text, text.count > 0 else { showAlert(.emptyTextField); return }
        
        // Here we creating .txt file from string and uploading it
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent("input.txt")
        
        do {
            try text.write(to: fileUrl, atomically: true, encoding: .utf8)
            let fileData = try Data(contentsOf: fileUrl, options: .alwaysMapped)
            Networking.shared.download(txtFileData: fileData) { [weak self] isSuccess, mp4FileURL in
                guard let self = self else { return }
                if isSuccess {
                    if let safeMp4FileURL = mp4FileURL {
                        // Here we showing own video from server in player
                        let player = AVPlayer(url: safeMp4FileURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true)
                    } else {
                        self.showAlert(.errorOnGettingVideo)
                    }
                } else {
                    self.showAlert(.errorOnGettingVideo)
                }
            }
        } catch {
            showAlert(.unknownError)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension HomeViewController {
    
    func activityControl(hide: Bool) {
        if hide {
            activityControl.removeFromSuperview()
            activityControlBackgroundView.removeFromSuperview()
        } else {
            // Setup activityControlBackgroundView
            view.addSubview(activityControlBackgroundView)
            activityControlBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activityControlBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                activityControlBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
                activityControlBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                activityControlBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])
            
            // Setup activityControlBackgroundView
            activityControlBackgroundView.addSubview(activityControl)
            activityControl.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activityControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
}

extension HomeViewController {
    
    enum AlertType {
        case unknownError
        case emptyTextField
        case errorOnGettingVideo
    }
    
    func showAlert(_ type: AlertType) {
        
        activityControl(hide: true)
        
        var alertTitle: String
        var alertMessage: String
        var actionTitle: String
        
        switch type {
        case .unknownError:
            alertTitle = "Unknown error"
            alertMessage = "unknown error"
            actionTitle = "Ok"
        case .emptyTextField:
            alertTitle = "Empty search Field"
            alertMessage = "Please fill search text Field"
            actionTitle = "Ok"
        case .errorOnGettingVideo:
            alertTitle = "Error on sending video"
            alertMessage = "Please try again"
            actionTitle = "Ok"
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - Layout
private extension HomeViewController {
    
    func configureUI() {
        // View
        view.backgroundColor = R.color.lightBlue()
        layout()
    }
    
    func layout() {
        
        // search label
        view.addSubview(searchLabel)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            searchLabel.heightAnchor.constraint(equalToConstant: 40),
            searchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            searchLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
        
        // Setup text view
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: searchLabel.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: searchLabel.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: searchLabel.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        // Setup controlStackView
        view.addSubview(controlStackView)
        controlStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controlStackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 24),
            controlStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            controlStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
        
        // Setup search Button
        controlStackView.addArrangedSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Setup upload button
        controlStackView.addArrangedSubview(customizeButton)
        customizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customizeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
