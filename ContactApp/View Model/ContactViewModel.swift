

import Foundation

class ContactViewModel {
    
    var contacts: [ContactModel] = []

    func getContacts() -> [ContactModel] {
        return contacts
    }
    
    func fetchDataFromPList() {
        guard let path = Bundle.main.path(forResource: "Contacts", ofType: "plist") else { return }
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let plist = try! PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: Any]] else { return }
        for item in plist {
            let person = item as? [String: String]
            let profilePicture = person?["profile_picture"] ?? ""
            let firstName = person?["first_name"] ?? ""
            let lastName = person?["last_name"] ?? ""
            let phoneNumber = person?["phone_number"] ?? ""
            let email = person?["email"] ?? ""
            let contact = ContactModel(profilePicture: profilePicture, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
            contacts.append(contact)
        }
    }
}
