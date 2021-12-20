//
//  TranslateViewController.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 29/11/2021.
//

import UIKit

class TranslateViewController: UIViewController {
  
    //  MARK: - PROPERTIES & OUTLETS
    
    private let service = TranslateService()
    private var pickerView = UIPickerView()
    private var langageSymbSelected = String()
    
    @IBOutlet weak var translateDestinationLanguage: UITextField!
    @IBOutlet weak var translateSourceText: UITextView!
    @IBOutlet weak var translateDestinationText: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    
    //  MARK: - IBACTIONS
    
    @IBAction func deleteSourceTextButtonTapped(_ sender: UIButton) {
        translateSourceText.text = ""
        translateSourceText.backgroundColor = UIColor(named: "CBlueLightBKGR")// Blue light
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        translateText()
    }

    //  MARK: - OVERRIDES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        translateDestinationLanguage.inputView = pickerView
        
        translateActivityIndicator.isHidden = true
    }
    
    //  MARK: - METHODS
    
    func translateText() {
        toggleActivityIndicator(visible: true, activityIndicator: translateActivityIndicator, button: translateButton)
        guard translateDestinationLanguage.text != nil,
            translateSourceText.text != nil else {
                presentAlert(message: "Please select a destination language and enter a source text.")
                toggleActivityIndicator(visible: false, activityIndicator: translateActivityIndicator, button: translateButton)
                return }
        // Submit the translation with the destinationLanguage and text input
        service.destinationLanguage = langageSymbSelected
        service.translateInput = translateSourceText.text
        service.getTranslation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let translation):
                    self?.update(data: translation)
                case .failure(let error):
                    self?.presentAlert(message: "Network error : \(error)")
                }
            }
        }
    }

    private func update(data: TranslateLang) {
        toggleActivityIndicator(visible: false, activityIndicator: translateActivityIndicator, button: translateButton)
        translateDestinationText.text = data.translations[0].text
        //print(" detected source langage = \(data.translations[0].detectedSourceLanguage)" )
        }
    }

  
extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return CountriesLangTarget.count
        }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return CountriesLangTarget[row][1]
        }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        translateDestinationLanguage.text = CountriesLangTarget[row][0] + " " + CountriesLangTarget[row][1]
        langageSymbSelected = CountriesLangTarget[row][0]
        translateDestinationLanguage.backgroundColor = UIColor(named: "CBlueLightBKGR")
        translateDestinationText.text = ""
        self.view.endEditing(true)
    }
}
    

 


