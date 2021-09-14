//
//  CustomizeViewController.swift
//  Interective Learning App
//
//  Created by Prefect on 11.09.2021.
//

import UIKit
import AVFoundation

class CustomizeViewController: UIViewController {
    
    private var spikerVoiceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sairaSemiCondensedRegular(size: 26)
        label.textColor = .black
        label.text = "Current spiker voice"
        label.textAlignment = .left
        return label
    }()
    
    private var spikerSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        return segmentControl
    }()
    
    private var spikerPlaySampleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.lightYellow()
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Play", for: .normal)
        return button
    }()
    
    private var spikerLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sairaSemiCondensedRegular(size: 26)
        label.textColor = .black
        label.text = "Current speecher face"
        label.textAlignment = .left
        return label
    }()
    
    private var spikerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.image = UIImage(named: "gordon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var spikerChoosingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.lightYellow()
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Choose photo", for: .normal)
        return button
    }()
    
    //MARK: - Variables
    var player: AVAudioPlayer?
    var imagePicker = UIImagePickerController()
    
    //MARK: - VC cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        configureUI()
        setupSegmentControl()
    }
    
    func configureUI() {
        
        // Setup specherLabel
        view.addSubview(spikerVoiceLabel)
        spikerVoiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spikerVoiceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            spikerVoiceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            spikerVoiceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            spikerVoiceLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        // Setup speecherSegmentControl
        view.addSubview(spikerSegmentControl)
        spikerSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spikerSegmentControl.topAnchor.constraint(equalTo: spikerVoiceLabel.bottomAnchor, constant: 10),
            spikerSegmentControl.trailingAnchor.constraint(equalTo: spikerVoiceLabel.trailingAnchor),
            spikerSegmentControl.leadingAnchor.constraint(equalTo: spikerVoiceLabel.leadingAnchor)
        ])
        
        // Setup speecherPlaySampleButton
        view.addSubview(spikerPlaySampleButton)
        spikerPlaySampleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spikerPlaySampleButton.topAnchor.constraint(equalTo: spikerSegmentControl.bottomAnchor, constant: 24),
            spikerPlaySampleButton.trailingAnchor.constraint(equalTo: spikerVoiceLabel.trailingAnchor, constant: -24),
            spikerPlaySampleButton.leadingAnchor.constraint(equalTo: spikerVoiceLabel.leadingAnchor, constant: 24),
            spikerPlaySampleButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Setup speechLabel
        view.addSubview(spikerLabel)
        spikerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spikerLabel.topAnchor.constraint(equalTo: spikerPlaySampleButton.bottomAnchor, constant: 24),
            spikerLabel.trailingAnchor.constraint(equalTo: spikerVoiceLabel.trailingAnchor),
            spikerLabel.leadingAnchor.constraint(equalTo: spikerVoiceLabel.leadingAnchor),
            spikerLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Setup speecherImageView
        view.addSubview(spikerImageView)
        spikerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spikerImageView.topAnchor.constraint(equalTo: spikerLabel.bottomAnchor, constant: 24),
            spikerImageView.leadingAnchor.constraint(equalTo: spikerLabel.leadingAnchor, constant: 24),
            spikerImageView.trailingAnchor.constraint(equalTo: spikerLabel.trailingAnchor, constant: -24),
            spikerImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Setup speecherChosingButton
        view.addSubview(spikerChoosingButton)
        spikerChoosingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spikerChoosingButton.topAnchor.constraint(equalTo: spikerImageView.bottomAnchor, constant: 24),
            spikerChoosingButton.leadingAnchor.constraint(equalTo: spikerPlaySampleButton.leadingAnchor),
            spikerChoosingButton.trailingAnchor.constraint(equalTo: spikerPlaySampleButton.trailingAnchor),
            spikerChoosingButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupSegmentControl() {
        
        for (index, specher) in SpecherType.allCases.enumerated() {
            spikerSegmentControl.insertSegment(withTitle: specher.rawValue, at: index, animated: false)
            if Constants.currentSpecher == specher {
                spikerSegmentControl.selectedSegmentIndex = index
            }
        }
    }
    
    func addTargets() {
        spikerPlaySampleButton.addTarget(self, action: #selector(playSoundTapped), for: .touchUpInside)
        spikerSegmentControl.addTarget(self, action: #selector(chooseSpeecherSegmentTapped), for: .valueChanged)
        spikerChoosingButton.addTarget(self, action: #selector(chooseSpecherImageTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension CustomizeViewController {
    
    @objc func playSoundTapped() {
        guard let url = Bundle.main.url(forResource: Constants.currentSpecher.rawValue, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func chooseSpeecherSegmentTapped() {
        // Show selector
        switch spikerSegmentControl.selectedSegmentIndex {
        case 0:
            Constants.currentSpecher = .ljspeech
        case 1:
            Constants.currentSpecher = .netherlands
        default:
            Constants.currentSpecher = .ljspeech
        }
    }
    
    enum Spiker: String, CaseIterable {
        case gordon
        case bogdan
        case alim
        case oksi
        case pasha
        case pashatech
        case sasha
    }
    
    @objc func chooseSpecherImageTapped() {
        
        let alert = UIAlertController(title: "Chose spiker", message: "or you can add own", preferredStyle: .actionSheet)
        Spiker.allCases.forEach { spicker in
            let action = UIAlertAction(title: spicker.rawValue, style: .default) { _ in
                Constants.currentFaceName = spicker.rawValue
                self.loadSpikerFace(spicker)
            }
            alert.addAction(action)
        }
        let ownPhotoAlert = UIAlertAction(title: "Choose own photo", style: .default) { _ in
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        alert.addAction(ownPhotoAlert)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    func loadSpikerFace(_ spiker: Spiker) {
        spikerImageView.image = UIImage(named: spiker.rawValue)
    }
}

// MARK: - Image picker
extension CustomizeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            spikerImageView.image = image
            let newImageName = UUID().uuidString
            Constants.currentFaceName = newImageName
            Networking.shared.uploadImage(name: newImageName, data: image.pngData()!)
        } else {
            let alert = UIAlertController(title: "Alert importing image",
                                          message: "message",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        dismiss(animated: true)
    }
}
