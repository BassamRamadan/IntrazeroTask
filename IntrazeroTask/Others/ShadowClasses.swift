
import UIKit


class ViewShadow: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 20
        clipsToBounds = true
        
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.blue.cgColor
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                          y: bounds.maxY + layer.shadowRadius,
                                                          width: bounds.width,
                                                          height: layer.shadowRadius),
                                        byRoundingCorners: [.bottomLeft, .bottomRight],
                                        cornerRadii: CGSize(width: 15.0, height: 0.0)).cgPath
    }
}
class LabelShadow: PaddingLabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
}
@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

class imageShadow: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}
