//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
//    var delegate =
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency:String) {
        let urlString = "\(baseURL)\(currency)"
        print(urlString)
        performRequestion(with: urlString)
        
        
    }
    
    func performRequestion(with urlString:String) {
        if let url = URL(string: urlString){
            let urlSession = URLSession(configuration:.default)
            let task = urlSession.dataTask(with: url) {(data,resoonse,error) in
                if error != nil{
                    print(error)
                }
                if let safedData = data {
                    let dataString = String(data: safedData, encoding: String.Encoding.utf8) as String?
                    print(dataString)
                }
            }
            task.resume()
        }
    }
    
}
