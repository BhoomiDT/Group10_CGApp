import UIKit

class AssistantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    var messages = [ChatMessage(text: "Hello! I am your AI Assistant.", isUser: false)]

    override func viewDidLoad() {
        super.viewDidLoad()
     
        searchBar.barTintColor = .appBackground
        tableView.backgroundColor = .appBackground
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.register(UINib(nibName: "aiCellView", bundle: nil), forCellReuseIdentifier: "aiCellView")
        tableView.sectionHeaderTopPadding = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbMove), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func searchBarSearchButtonClicked(_ sb: UISearchBar) {
        guard let text = sb.text, !text.isEmpty else { return }
        sb.text = ""; sb.resignFirstResponder()
        insert(ChatMessage(text: text, isUser: true))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.insert(ChatMessage(text: AssistantBrain.getAnswer(for: text), isUser: false))
        }
    }
    
    func insert(_ msg: ChatMessage) {
        messages.insert(msg, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }

    @objc func kbMove(_ n: NSNotification) {
        let h = (n.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        bottomConstraint.constant = h - view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
    }

    @objc func kbHide() {
        bottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) { view.endEditing(true) }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { messages.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aiCellView", for: indexPath) as! aiCellView
        cell.configure(with: messages[indexPath.row])
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
    }
}

    