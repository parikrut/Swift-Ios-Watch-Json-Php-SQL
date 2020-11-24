
import UIKit
import WatchConnectivity

// step 1 - create storyboard with home page and drag splitview
// step 2 - create new objects:
//          - GetData.swift (NSObject)
//          - MyDataTableViewCell.swift (UITableViewCell)
//          - TableViewController.swift (UITableViewController)
//          - DetailsViewController.swift (UIViewController)
// step 3 - add items to MyDataTableViewCell


class ViewController: UIViewController,UIPopoverPresentationControllerDelegate, WCSessionDelegate {
    
    var lastMessage: CFAbsoluteTime = 0
    var Cars : [CarObject] = []
    let getData = GetData()
    var timer : Timer!

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        var replyValues = Dictionary<String, AnyObject>()
        
        
        if (message["getCarData"] != nil)
        {
            // step 8b - serialize and send the fake data to the watch for display
            // note line of code below needed to prevent app crash.
            NSKeyedArchiver.setClassName("CarObject", for: CarObject.self)
            let carData = NSKeyedArchiver.archivedData(withRootObject: Cars)
            
            
            replyValues["carData"] = carData as AnyObject?
            replyHandler(replyValues)
        }
    }
    
    func initFakeDetails()
    {
        for anItem in getData.dbData! {
            // or [[String:AnyObject]]
            
           // print("Item inside ->>> \(anItem["Model"])" )
            let Model = anItem["Model"]! as! String
            let Make = anItem["Make"]! as! String
            let Color = anItem["Color"]! as? String
            let Year = anItem["Year"]! as? String
            let Price = (anItem["Price"]! as? String)!
            let NewOrUsed = (anItem["NewOrUsed"]! as? String)!

            let carObj = CarObject()
            carObj.initWithData(Model: Model, Make: Make, Year: Year!, Color: Color!, NewOrused: NewOrUsed, Price: Price)
            Cars.append(carObj)

       //     print("Car obj ->>>\(carObj.Color)")
            print("Cars ->>> \(Cars)")
        }

    }
    
    func sendWatchMessage(_ msgData:Data) {
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        // if less than half a second has passed, bail out
        if lastMessage + 0.5 > currentTime {
            return
        }
        
        // send a message to the watch if it's reachable
        if (WCSession.default.isReachable) {
            
            let message = ["carData": msgData]
            WCSession.default.sendMessage(message, replyHandler: nil)
        }
        
        // update our rate limiting property
        lastMessage = CFAbsoluteTimeGetCurrent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshTable), userInfo: nil, repeats: true);
        
        getData.jsonParser()
        
     //   print("Json Data ->>>> \(getData.jsonParser())")
        
// print("Carsss data ->> \()")
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()

            if session.isPaired != true {
                print("Apple Watch is not paired")
            }

            if session.isWatchAppInstalled != true {
                print("WatchKit app is not installed")
            }
        } else {
            print("WatchConnectivity is not supported on this device")
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func refreshTable(){
        if(getData.dbData != nil)
        {
            if (getData.dbData?.count)! > 0
            {
             //   print("DB Data ->>> \(getData.dbData!)")
                
                initFakeDetails()
                self.timer.invalidate()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

