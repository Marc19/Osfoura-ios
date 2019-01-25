import Foundation

public class SearchDataController
{
    var tweeters: [Tweeter]?
    
    init()
    {
        
    }
    
    func searchFor(searchTerm: String, successHandler: @escaping ([Tweeter]) -> Void, errorHandler: @escaping (SearchError) -> Void )
    {
        
    }
    
    class Factory
    {
        static let simulatingResults: Bool = true
        
        static func newInstance() -> SearchDataController
        {
            if(simulatingResults)
            {
                return SearchDataControllerProxy()
            }
            else
            {
                return SearchDataController()
            }
        }
        
    }
    
    enum SearchError
    {
        case ERROR_TIMEOUT
        case ERROR_SERVER
        case ERROR_OFFLINE
    }
    
    class SearchDataControllerProxy : SearchDataController
    {
        private let isSimulatingEmptyResults: Bool = false
        private let isSimulatingTimeoutError: Bool = false
        private let isSimulatingOfflineError: Bool = false
        private let isSimulatingAPIError: Bool = true
        
        override func searchFor(searchTerm: String, successHandler: @escaping ([Tweeter]) -> Void, errorHandler: @escaping (SearchError) -> Void)
        {
            if(isSimulatingOfflineError)
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                {
                    errorHandler(.ERROR_OFFLINE)
                }
            }
            else if(isSimulatingAPIError)
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                {
                    errorHandler(.ERROR_SERVER)
                }
            }
            else if(isSimulatingTimeoutError)
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                {
                    errorHandler(.ERROR_TIMEOUT)
                }
            }
            else if(isSimulatingEmptyResults)
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                {
                    self.tweeters = []
                    successHandler(self.tweeters!)
                }
            }
            else
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                {
                    self.tweeters = [
                        Tweeter(name: "marc", screenName: "@marcovic", numberOfFollowers: 30, profilePictureUrl: "luka", isVerified: true, tweeterId: "2"),
                    Tweeter(name: "marc", screenName: "@marcovic", numberOfFollowers: 30, profilePictureUrl: "luka", isVerified: false, tweeterId: "2"),
                    Tweeter(name: "marc", screenName: "@marcovic", numberOfFollowers: 100, profilePictureUrl: "luka", isVerified: true, tweeterId: "2"),
                    Tweeter(name: "marc", screenName: "@marcovic", numberOfFollowers: 30, profilePictureUrl: "luka", isVerified: false, tweeterId: "2"),
                    Tweeter(name: "marc", screenName: "@marcovic", numberOfFollowers: 30, profilePictureUrl: "luka", isVerified: true, tweeterId: "2")]
                    
                    successHandler(self.tweeters!)
                }
            }
        }
    }
}
