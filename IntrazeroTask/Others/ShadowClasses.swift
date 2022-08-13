
import UIKit


class ViewShadow: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.3
        layer.cornerRadius = 15
    }
}

class ButtonShadow: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
        layer.cornerRadius = 5
    }
}


class TextFieldShadow: UITextField {
    
    let padding = UIEdgeInsets(top: 0,left: 15,bottom: 0,right: 15)
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
class TextViewShadowWithBorder: UITextView {
    override func awakeFromNib() {
        super.awakeFromNib()
        textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(named: "yellow")?.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}
class TextViewShadow: UITextView {
    override func awakeFromNib() {
        super.awakeFromNib()
        textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
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
