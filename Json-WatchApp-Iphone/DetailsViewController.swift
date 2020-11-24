

import UIKit

class DetailsViewController: UIViewController {

    // step 12 - create variables and link them to sb
    @IBOutlet var lblMake : UILabel!
    @IBOutlet var lblModel : UILabel!
    @IBOutlet var lblYear : UILabel!
    @IBOutlet var lblColor : UILabel!
    @IBOutlet var lblPrice : UILabel!
    @IBOutlet var lblNewOrUsed : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // step 13 - create method below to populate details page
    // step 14 - move back to table view controller 
    func updatePerson(getData : GetData, select : Int)
    {
        let rowData = (getData.dbData?[select])! as NSDictionary
       
        self.lblMake.text = rowData["Make"] as? String
        self.lblModel.text = rowData["Model"] as? String
        self.lblColor.text = rowData["Color"] as? String
        self.lblYear.text = rowData["Year"] as? String
        self.lblPrice.text = rowData["Price"] as? String
        self.lblNewOrUsed.text = rowData["NewOrUsed"] as? String

        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
