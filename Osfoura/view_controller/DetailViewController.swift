import UIKit

class DetailViewController: UIViewController
{
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var screenName: UILabel!
    @IBOutlet var numberOfFollowers: UILabel!
    
    var profilePicture_: String?
    var name_: String?
    var screenName_: String?
    var numberOfFollowers_: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let pp = profilePicture_{
            profilePicture.image = UIImage(named: pp)
        }
        
        if let n = name_{
            name.text = n
        }
        
        if let sn = screenName_{
            screenName.text = sn
        }
        
        if let nof = numberOfFollowers_{
            numberOfFollowers.text = nof
        }
    }
    

    

}
