import UIKit

class SearchViewController: UIViewController, UITableViewDataSource
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        cell.profilePicture?.image = UIImage(named: "luka")
        cell.profilePicture?.layer.cornerRadius = (cell.profilePicture?.frame.height)!/2
        cell.profilePicture?.clipsToBounds = true
        
        cell.verified?.layer.cornerRadius = (cell.verified?.frame.height)!/2
        cell.verified?.clipsToBounds = true
        
        cell.name.text = "Marc Iskander"
        cell.screenName.text = "@marcovic"
        cell.numberOfFollowers.text = "30 followers"
        return cell
    }

}
