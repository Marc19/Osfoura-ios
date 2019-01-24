import Foundation

public class Tweeter
{
    let name: String
    let screenName: String
    let numberOfFollowers: Int
    let profilePictureUrl: String
    let isVerified: Bool
    let tweeterId: String
    
    init(name:String, screenName: String, numberOfFollowers: Int, profilePictureUrl: String, isVerified:Bool, tweeterId: String)
    {
        self.name = name
        self.screenName = screenName
        self.numberOfFollowers = numberOfFollowers
        self.profilePictureUrl = profilePictureUrl
        self.isVerified = isVerified
        self.tweeterId = tweeterId
        
    }
}
