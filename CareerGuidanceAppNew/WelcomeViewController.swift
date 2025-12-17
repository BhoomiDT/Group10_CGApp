import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var continueOnboarding: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSheetPresentation()
    }

    private func setupSheetPresentation() {
      
        if let sheet = self.sheetPresentationController {
          
            let customDetent = UISheetPresentationController.Detent.custom { context in
                return context.maximumDetentValue * 0.85
            }
            
        
            sheet.detents = [customDetent]
            
            
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
    }

    @IBAction func continueTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
