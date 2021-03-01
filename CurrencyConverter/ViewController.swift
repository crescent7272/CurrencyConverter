//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ruveyda Hilal Inan on 01/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var brlLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var uahLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    var url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
    let session = URLSession.shared
    var task : URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title:"Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                
                if data != nil {
                    
                    do {
                        
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let brl = rates["BRL"] as? Double {
                                    
                                    self.brlLabel.text = "BRL: \(brl)"
                                    
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    
                                    self.jpyLabel.text = "JPY: \(jpy)"

                                }
                                
                                if let eur = rates["EUR"] as? Double {
                                    
                                    self.eurLabel.text = "EUR: \(eur)"

                                }
                                
                                if let uah = rates["UAH"] as? Double {
                                    
                                    self.uahLabel.text = "UAH: \(uah)"

                                }
                                
                                if let cad = rates["CAD"] as? Double {
                                    
                                    self.cadLabel.text = "CAD: \(cad)"
                                
                                }
                                
                                if let trl = rates["TRY"] as? Double {
                                    
                                    self.tryLabel.text = "TRY: \(trl)"
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
                    
                    }
                    catch {
                        
                        print("error")
                    }
                    
                }
                
            }
            
            
        })
        
    }
    
    @IBAction func getRates(_ sender: Any) {
        
        self.task!.resume()
        
    }
    
}

