//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 16/11/2021.
//

import UIKit

final class CurrencyViewController: UIViewController {
  
    //  MARK: - PROPERTIES & OUTLETS
    
    private let service = FixerService()
    private var CurrencySymbSelected = String() // Currency symbol selected in the View
    private var searchCurrency = [String]()     // Currrent list of currency display in the table View
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var sourceAmount: UITextField!
    @IBOutlet weak var convertedAmount: UITextField!
    @IBOutlet weak var destinationSymb: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
 
    //  MARK: - OVERRIDES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        // Initialize the the list of currency to display with the complete list currencyName
        searchCurrency = currencyName
        searchBar.isHidden = true
        tblView.isHidden = true
        convertButton.isHidden = false
        
        searchBar.delegate = self
        tblView.delegate = self
        tblView.dataSource = self
    }

    //  MARK: - IBACTIONS
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        toggleActivityIndicator(visible: true, activityIndicator: activityIndicator, button: convertButton)
        guard sourceAmount.text != nil,
            let input = sourceAmount.text,
            let inputValue = Double(input) else {
                presentAlert(message: "Please enter a correct value to convert")
                toggleActivityIndicator(visible: false, activityIndicator: activityIndicator, button: convertButton)
                return }
        
        service.apiSymb = CurrencySymbSelected  // retrieve the destination currency selected
        service.getRate { [weak self] result in 
            DispatchQueue.main.async { // back to the main thread
                switch result {
                case .success(let rate):
                    self?.update(inputValue: inputValue, rate: rate)
                case .failure(let error):
                    self?.presentAlert(message: "Network error : \(error)")
                }
            }
        }
    }
    
    // display the searchBar ans the tableView when the destinationCurrency textView is touch down
    @IBAction func destinationCurrencyTouchDown(_ sender: UITextField) {
        convertButton.isHidden = true
        searchBar.isHidden = false
        tblView.isHidden = false
        // Initialize the the list of currency to display with the complete list currencyName
        searchCurrency = currencyName
    }
    
    @IBAction func sourceAmountEditDidEnd(_ sender: UITextField) {
        sender.backgroundColor = UIColor(named: "CBlueLightBKGR")   // Blue light
    }
    
    
    //  MARK: - METHODS
    
    private func update(inputValue: Double, rate: ExchangeRate) {
        // update champ storyboard
        toggleActivityIndicator(visible: false, activityIndicator: activityIndicator, button: convertButton)
        guard let exRate = rate.rates[CurrencySymbSelected] else {return}
        let outPutCalc = inputValue * exRate
        convertedAmount.text = outPutCalc.getStringValue(withFloatingPoints: 2)
    }
}

    // MARK: - EXTENSIONS

extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {

    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCurrency.count
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate Identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = searchCurrency[indexPath.row]
       return cell!
    }
    
    // When a row is selected :
    // copy the selection in the searchBar text
    // Hide de the searchBar and the tableView
    // retrieve the the currency symbol for network call
    // and change the backgroundcolor to light blue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(searchCurrency[indexPath.row])
        searchBar.text = searchCurrency[indexPath.row]
        tblView.isHidden = true
        searchBar.isHidden = true
        convertButton.isHidden = false
        destinationSymb.text = searchCurrency[indexPath.row]
        CurrencySymbSelected = currencySymb[currencyName.firstIndex(of: destinationSymb.text!)!]
        destinationSymb.backgroundColor = UIColor(named: "CBlueLightBKGR")// Blue light
        convertedAmount.text  =  ""
    }
}

extension CurrencyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCurrency = []
        tblView.isHidden = false
        if searchText == " " {
            searchCurrency = currencyName
        } else {
                // fill the currency list to display in the table view with the currency name containing the input text
                // If you want to filter the tableView with the prefix of the input text replace the for...in by :
                // searchCurrency = currencyName.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
            for element in currencyName {
               if element.lowercased().contains(searchText.lowercased()) {
                   searchCurrency.append(element)
                }
            }
            tblView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tblView.isHidden = true
        searchBar.isHidden = true
    }
}
