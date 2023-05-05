

import UIKit

class ContactDetailsViewController: UIViewController {

// MARK: - @IBOutlet

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var person: ContactModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateProfile()
    }
    
    func updateProfile() {
        let firstName = person?.firstName ?? ""
        let lastName = person?.lastName ?? ""
        let profilePicture = person?.profilePicture ?? ""
        imageView.image = UIImage(named: profilePicture)
        nameLabel.text = firstName + " " + lastName
        phoneLabel.text = person?.phoneNumber
        emailLabel.text = person?.email
    }
}
