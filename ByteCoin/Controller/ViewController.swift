//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()

    @IBOutlet weak var currencyPikerView: UIPickerView!
    @IBOutlet weak var bicoinLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPikerView.dataSource = self
        currencyPikerView.delegate = self
        coinManager.delegate = self
        
        // Do any additional setup after loading the view.
    }
}

extension  ViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let currency = coinManager.currencyArray[row]
        unitLabel.text = currency
        coinManager.getCoinPrice(for:currency)
    }
    
}


extension ViewController:CoinManagerDelegate{
    
    func didUpdateCoin(coin:CoinData){
        DispatchQueue.main.async
            {self.bicoinLabel.text = String(format:"%.f",coin.price)}
    }
    
    func didHandleError(error:Error){
        
    }
    
}
