import Foundation

public class KPAuthentication {
    public static let shared = KPAuthentication() // singleton
    
    fileprivate var _isLoggedIn: Bool = false
    
    fileprivate init() {
        _isLoggedIn = UserDefaults.standard.string(forKey: defaultKeys.authToken) != nil
    }
    
    func login(email: String, password: String, completion: ((Bool) -> Void)?) {
        let url = "/API/Customer/AuthenticateCustomer.ashx"
        
        KPService.getJSON(withURLString: url, params: ["EmailAddress": email, "Password": password], completion: { (values, error) in
            
            guard let safeCompletion = completion else {
                return
            }
            
            if let _ = error {
                safeCompletion(false)
                return
            }
            
            if let safeValues = values, let token = safeValues["Token"] as? String, String(describing: token) != "<null>" {
                self.setUserValues(userValues: safeValues)
                self._isLoggedIn = true
                
                safeCompletion(true)
            } else {
                safeCompletion(false)
            }
        })
    }
    
    func login(userValues: [String: Any?]) {
        setUserValues(userValues: userValues)
        self._isLoggedIn = true
    }
    
    fileprivate func setUserValues(userValues: [String: Any?]) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(userValues["Token"]!, forKey: defaultKeys.authToken)
        userDefaults.set(userValues["FirstName"]!, forKey: defaultKeys.firstName)
        userDefaults.set(userValues["LastName"]!, forKey: defaultKeys.lastName)
        userDefaults.set(userValues["EmailAddress"]!, forKey: defaultKeys.emailAddress)
        userDefaults.set(userValues["Subscribed"]!, forKey: defaultKeys.subscibed)
    }
    
    func logout() {
        _isLoggedIn = false
        
        KPShoppingCart.instance.products = []
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return _isLoggedIn
    }
}
