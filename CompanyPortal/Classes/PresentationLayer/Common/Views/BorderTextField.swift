import UIKit
import PinLayout
import RxSwift

class BorderTextField: UITextField {

    private var bag: DisposeBag = .init()
    private let borderView = UIView()

    @IBInspectable
    var borderThick: CGFloat = 0 {
        didSet {
            self.layout()
        }
    }

    @IBInspectable
    var defaultBorderColor: UIColor = .clear {
        didSet {
            self.borderView.backgroundColor = self.defaultBorderColor
        }
    }

    @IBInspectable
    var activeBorderColor: UIColor = .clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override func becomeFirstResponder() -> Bool {
        let flag = super.becomeFirstResponder()
        if flag { self.borderView.backgroundColor = activeBorderColor }
        return flag
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        let flag = super.resignFirstResponder()
        if flag { self.borderView.backgroundColor = defaultBorderColor }
        return flag
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }

    // MARK: - Private
    
    private func addSubviews() {
        isUserInteractionEnabled = true
        borderStyle = .none
        addSubview(self.borderView)
    }
    
    private func layout() {
        self.borderView.pin
            .bottom()
            .horizontally()
            .height(borderThick)
    }
    
    private func setup() {
        self.addSubviews()
    }
    
    private func setTextObserver() {
        rx.text.subscribe(onNext: { [weak self] text in
            self?.textDidChange(text)
        })
        .disposed(by: bag)
    }

    private func textDidChange(_ text: String?) { }
    
}
