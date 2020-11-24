

import UIKit

// Step 3 - add following outlets for table view cell and connect them in sb
// Step 4 - move on to GetData
class MyDataTableViewCell: UITableViewCell {

    @IBOutlet var myModel : UILabel!
    @IBOutlet var myMake : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
