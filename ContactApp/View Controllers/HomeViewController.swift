

import UIKit

class HomeViewController: UIViewController {

// MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var contacts: [ContactModel] = []
    var filteredContacts: [ContactModel] = []
    var contactViewModel: ContactViewModel = ContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateDataOnTableView()
        configureSearchBar()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateDataOnTableView() {
        contactViewModel.fetchDataFromPList()
        filteredContacts = contactViewModel.contacts
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") else { return UITableViewCell() }
        cell.textLabel?.text = filteredContacts[indexPath.row].firstName
        cell.detailTextLabel?.text = filteredContacts[indexPath.row].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToNextController(contact: contactViewModel.contacts[indexPath.row])
    }
    
    func navigateToNextController(contact: ContactModel) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as? ContactDetailsViewController else { return }
        vc.person = contact
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContacts = []
        if searchText == "" {
            filteredContacts = contactViewModel.contacts
        }
        for contact in contactViewModel.contacts {
            if contact.firstName.lowercased().contains(searchText.lowercased()) {
                filteredContacts.append(contact)
            }
        }
        tableView.reloadData()
    }
}
