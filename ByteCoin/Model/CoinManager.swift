//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CoinManagerDelegate{
    func didUpdateCoin(coin:CoinData)
    func didHandleError(error:Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
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
                    self.delegate?.didHandleError(error:error!)
                    return
                }
                if let safedData = data {
                     if let coinValue = self.parseData(safedData)
                        
                     {
                        print(coinValue)
                        self.delegate?.didUpdateCoin(coin: coinValue)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseData(_ coindata:Data) -> CoinData? {
        do {
            let coinDataJson = try JSON(data: coindata)
            let price = coinDataJson["last"].double
            let coinDataValue = CoinData(price: price!)
//            print(coinDataValue)
            return coinDataValue
        }
        catch{
            self.delegate?.didHandleError(error: error)
            return nil
        }
    }
    
}
