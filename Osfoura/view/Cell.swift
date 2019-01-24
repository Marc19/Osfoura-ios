import UIKit

class Cell: UITableViewCell {

    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var verified: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var screenName: UILabel!
    @IBOutlet var numberOfFollowers: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
