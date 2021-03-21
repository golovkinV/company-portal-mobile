import UIKit

final class StateButton: UIButton {
    var isActive = false {
        didSet {
            self.changeState()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 8
        titleLabel?.font = UIFont.font(ofSize: 17, weight: .medium)
    }

    private func changeState() {
        if self.isActive {
            backgroundColor = MainTheme.shared.selectedColor
            setTitleColor(MainTheme.shared.white, for: .normal)
        } else {
            backgroundColor = MainTheme.shared.selectedColor.withAlphaComponent(0.5)
            setTitleColor(MainTheme.shared.white.withAlphaComponent(0.8), for: .normal)
        }
        isEnabled = self.isActive
    }
}
