import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var searchDataController:SearchDataController?
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingAnimator: UIActivityIndicatorView!
    @IBOutlet var statusView: UIView!
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet var statusImageView: UIImageView!
    
    let timeoutErrorMessage:String = "It took so long to connect to the internet. You can try again."
    let offlineErrorMessage:String = "Couldn\'t connect to the internet. Please, connect and try again."
    let serverErrorMessage:String = "We encountered server error. Please, try again later."
    let emptyResultsMessage:String = "No tweeters found with the name"
    
    var selectedTweeter: Tweeter?
    
    //Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        searchTextField.becomeFirstResponder()
        prepareDataController()
    }
    
    //Initialization
    
    private func prepareDataController()
    {
        searchDataController = SearchDataController.Factory.newInstance()
    }
    
    private func prepareView(state:State)
    {
        switch state
        {
            case .SEARCHING:
                tableView.isHidden = true
                loadingAnimator.isHidden = false
                statusView.isHidden = true
            
            case .EMPTY_RESULTS:
                tableView.isHidden = true
                loadingAnimator.isHidden = true
                statusView.isHidden = false
                statusImageView.image = UIImage(named: "emptyResults")
                errorMessage.text = emptyResultsMessage + " '\(searchTextField.text!)'"
            
            case .OFFLINE_ERROR:
                tableView.isHidden = true
                loadingAnimator.isHidden = true
                statusView.isHidden = false
                statusImageView.image = UIImage(named: "error")
                errorMessage.text = offlineErrorMessage
            
            case .SERVER_ERROR:
                tableView.isHidden = true
                loadingAnimator.isHidden = true
                statusView.isHidden = false
                statusImageView.image = UIImage(named: "error")
                errorMessage.text = serverErrorMessage
            
            case .TIMEOUT_ERROR:
                tableView.isHidden = true
                loadingAnimator.isHidden = true
                statusView.isHidden = false
                statusImageView.image = UIImage(named: "error")
                errorMessage.text = timeoutErrorMessage
            
            case .WITH_RESULTS:
                tableView.isHidden = false
                loadingAnimator.isHidden = true
                statusView.isHidden = true
        }
    }
    
    @IBAction func didPressTryAgain(_ sender: UIButton)
    {
        searchTextField.becomeFirstResponder()
    }
    
    @IBAction func didPressSearch(_ sender: UITextField)
    {
        prepareView(state: .SEARCHING)
        
        searchFor(searchTerm: searchTextField.text ?? "")
    }
    
    //Handling TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (searchDataController?.tweeters?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        cell.profilePicture?.image = UIImage(named: (searchDataController?.tweeters?[indexPath.row].profilePictureUrl)!)
        cell.profilePicture?.layer.cornerRadius = (cell.profilePicture?.frame.height)!/2
        cell.profilePicture?.clipsToBounds = true
        
        if((searchDataController?.tweeters?[indexPath.row].isVerified)!)
        {
            cell.verified.isHidden = false
            cell.verified?.layer.cornerRadius = (cell.verified?.frame.height)!/2
            cell.verified?.clipsToBounds = true
        }
        else
        {
            cell.verified.isHidden = true
        }
        
        cell.name.text = searchDataController?.tweeters?[indexPath.row].name
        cell.screenName.text = searchDataController?.tweeters?[indexPath.row].screenName
        cell.numberOfFollowers.text = "\(searchDataController!.tweeters![indexPath.row].numberOfFollowers) followers"
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedTweeter = searchDataController?.tweeters![indexPath.row]
        
//        selectedTweeter = Tweeter(name: "marc", screenName: "@marcovic", numberOfFollowers: 30, profilePictureUrl: "<#T##String#>", isVerified: true, tweeterId: "2")
        
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let detail = segue.destination as! DetailViewController
        
        detail.profilePicture_ = (selectedTweeter?.profilePictureUrl)!
        detail.name_ = selectedTweeter?.name
        detail.screenName_ = selectedTweeter?.screenName
        detail.numberOfFollowers_ = "\(selectedTweeter!.numberOfFollowers) followers"
    }
    
    //Searching
    
    private func searchFor(searchTerm: String)
    {
        if(!searchTerm.isEmpty && !(searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty))
        {
            searchDataController?.searchFor(searchTerm: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines), successHandler: searchSucceeded, errorHandler: searchFailed)
        }
        else
        {
            prepareView(state: .EMPTY_RESULTS)
        }
        
        searchTextField.resignFirstResponder()
    }
    
    private func searchFailed(searchError: SearchDataController.SearchError)
    {
        switch searchError
        {
            case .ERROR_TIMEOUT:
                prepareView(state: .TIMEOUT_ERROR)
            
            case .ERROR_OFFLINE:
                prepareView(state: .OFFLINE_ERROR)
            
            case .ERROR_SERVER:
                prepareView(state: .SERVER_ERROR)
        }
    }
    
    private func searchSucceeded(tweeters:[Tweeter])
    {
        if(tweeters.isEmpty)
        {
            prepareView(state: .EMPTY_RESULTS)
        }
        else
        {
            tableView.reloadData()
            prepareView(state: .WITH_RESULTS)
        }
    }
    
    private enum State
    {
        case SEARCHING
        case EMPTY_RESULTS
        case WITH_RESULTS
        case OFFLINE_ERROR
        case TIMEOUT_ERROR
        case SERVER_ERROR
    }
    
    //The color used for icons from flaticon.com is: #868B8F
}
