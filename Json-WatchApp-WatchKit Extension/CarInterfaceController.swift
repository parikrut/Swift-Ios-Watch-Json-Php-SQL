//
//  CarInterfaceController.swift
//  Json-WatchApp-WatchKit Extension
//
//  Created by Xcode User on 2020-11-23.
//

import WatchKit
import Foundation
import WatchConnectivity

class CarInterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet var carTable : WKInterfaceTable!
    var cars : [CarObject] = []
    
    // step 6 implement the watch connectivity delegate interface and methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        var replyValues = Dictionary<String, AnyObject>()
        
        let loadedData = message["carData"]
        
        let loadedCar = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? [CarObject]
        
        cars = loadedCar!
        
        
        
        replyValues["status"] = "Car Received" as AnyObject?
        replyHandler(replyValues)
    }
    
    // step 6b - check to see if watch can connect with iPhone
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
            
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (WCSession.default.isReachable) {
            
            // step 6c - send a message to the phone requesting data
            let message = ["getCarData": [:]]
            WCSession.default.sendMessage(message, replyHandler: { (result) -> Void in
                // TODO: Handle your data from the iPhone
                
                if result["carData"] != nil
                {
                    let loadedData = result["carData"]
                    
                    
                    // step 6d - deserialize the data from the watch
                    NSKeyedUnarchiver.setClass(CarObject.self, forClassName: "CarObject")
                    // causes app crash because decode not linked properly error
                    // above line of code needed to prevent this crash
                    let loadedCar = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? [CarObject]
                    print("Loded data->>>>\(loadedCar)")
                    self.cars = loadedCar!
                    print("Carsss ->>>> \(self.cars.count)")
                    self.carTable.setNumberOfRows(self.cars.count, withRowType: "CarRowController")
   // self.carTable.setNumberOfRows(self.cars.count,withRowType: "CarRowController")
                    
                    
                    for (index,prog) in self.cars.enumerated() {
                        let row = self.carTable.rowController(at: index) as! CarRowController
                        row.lblModel.setText(prog.Model)
                        row.lblMake.setText(prog.Make)
                        row.lblPrice.setText(prog.Price)
                        row.lblNewOrUsed.setText(prog.NewOrused)
                        row.lblColor.setText(prog.Color)
                        row.lblYear.setText(prog.Year)
                        
                    }
                }
                
            }, errorHandler: { (error) -> Void in
                // TODO: Handle error - iPhone many not be reachable
                print(error)
            })
            
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
