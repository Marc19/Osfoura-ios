import UIKit

class SearchViewController: UIViewController
{
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        myLabel.text = "Hello from view controller"
    }

}
