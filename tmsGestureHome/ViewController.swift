import UIKit

class ViewController: UIViewController {

    let staticView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    var movingView = UIView(frame: CGRect(x: 300, y: 300, width: 100, height: 100))
    let button = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        staticView.backgroundColor = .blue
        movingView.backgroundColor = .red
        
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(startAgain), for: .touchUpInside)
        
        view.addSubview(staticView)
        view.addSubview(movingView)
        view.addSubview(button)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panMoved(_:)))
        movingView.addGestureRecognizer(panGesture)
    }
    
    @objc func panMoved(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let point = gestureRecognizer.translation(in: view)
            gestureRecognizer.view?.center = CGPoint(x: (gestureRecognizer.view?.center.x ?? 0) + point.x,                                        y: (gestureRecognizer.view?.center.y ?? 0) + point.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: view)
            
                if staticView.frame.intersects(movingView.frame) {
                    gestureRecognizer.isEnabled = false
                    button.setTitle("Start again", for: .normal)
            }
        }
    }
    
    @objc func startAgain() {
        movingView.frame.origin = CGPoint(x: 300, y: 300)
        button.setTitle("Start", for: .normal)
        movingView.gestureRecognizers?.forEach { $0.isEnabled = true }
    }
}
