
import UIKit
import Firebase

final class PhoneNumberViewController: UIViewController, UITextViewDelegate{
    
    private var phoneNumberTextField = UITextField()
    private var verifyButton = UIButton()
    private var textViewForRules = UITextView()
    private var titleLabel = UILabel()
    private var phoneInputInformation = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBack()
        setPhoneNumberField()
        setVerifyButton()
        textViewSettings()
        labelsSettings()
        // Save for test
//        if let number = UserDefaults.standard.object(forKey: "phoneNumber") {
//            phoneNumberTextField.text = number as? String ?? ""
//        }
        
    }
    
    private func textViewSettings() {
        textViewForRules = UITextView()
        textViewForRules.translatesAutoresizingMaskIntoConstraints = false
        textViewForRules.isEditable = false
        textViewForRules.delegate = self
        
        view.addSubview(textViewForRules)
        
        NSLayoutConstraint.activate([
            textViewForRules.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            textViewForRules.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textViewForRules.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textViewForRules.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let attributedString = NSMutableAttributedString(string: " Продовужуючи, Ви погоджуєтесь зі всіма\n Правилами та Політикою конфіденційності")
        attributedString.addAttribute(.link, value: "alert1", range: NSRange(location: 41, length: 9))
        attributedString.addAttribute(.link, value: "alert2", range: NSRange(location: 54, length: 26))
        
        textViewForRules.linkTextAttributes = [
            .foregroundColor: UIColor.titlePurple,
            .underlineStyle: []
        ]
        
        textViewForRules.attributedText = attributedString
        textViewForRules.font = UIFont.systemFont(ofSize: 16)
        textViewForRules.textAlignment = .center
        textViewForRules.isUserInteractionEnabled = true
        textViewForRules.textColor = .lightGray
        textViewForRules.backgroundColor = .clear
    }
    
    private func labelsSettings() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 140, width: view.frame.width, height: 100))
        view.addSubview(titleLabel)
        titleLabel.center.x = view.center.x
        let text = "Приєднуйся до\n Merry Berry"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 13))
        attributedString.addAttribute(.foregroundColor, value: UIColor.titleforPhoneNumber, range: NSRange(location: 13, length: 13))
        titleLabel.attributedText = attributedString
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
    // input number
        
        phoneInputInformation = UILabel(frame: CGRect(x: 0, y: 260, width: view.frame.width, height: 15))
        view.addSubview(phoneInputInformation)
        phoneInputInformation.textAlignment = .center
        phoneInputInformation.font = UIFont.systemFont(ofSize: 12)
        phoneInputInformation.textColor = .white
        phoneInputInformation.center.x = view.center.x
        phoneInputInformation.text = "Введіть номер телефону, щоб увійти у застосунок"
    }
    
    private  func setPhoneNumberField() {
        phoneNumberTextField = {
            let textField = UITextField()
            textField.text = "+380"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.borderStyle = .none
            textField.becomeFirstResponder()
            textField.tintColor = .titlePurple
            textField.font = UIFont.boldSystemFont(ofSize: 50)
            textField.textContentType = .telephoneNumber
            textField.keyboardType = .phonePad
            textField.adjustsFontSizeToFitWidth = true
            textField.minimumFontSize = 20
            textField.delegate = self
            textField.backgroundColor = .clear
            textField.textColor = .black
            view.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 230),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                textField.heightAnchor.constraint(equalToConstant: 60)
            ])
            return textField
        }()
    }
    
    private func setVerifyButton() {
        verifyButton = {
            let button = UIButton(type: .system)
            button.setTitle("Продовжити", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.addTarget( self, action: #selector(verifyButtonTapped), for: .touchUpInside)
            button.frame.size = CGSize(width: 350, height: 70)
            button.layer.cornerRadius = button.frame.height / 2
            button.layer.masksToBounds = true
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.buttonBorder.cgColor
            button.backgroundColor = .buttonTint
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 70),
                button.widthAnchor.constraint(equalToConstant: 350)
            ])
            
            return button
        }()
    }
    
    @objc func verifyButtonTapped() {
        guard let phoneNumber = phoneNumberTextField.text else {
            print("Please enter a phone number")
            return
        }
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        sendVerificationCode(to: phoneNumber) { error in
            if let error = error {
                print("Error sending verification code: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {  
                let verificationCodeViewController = VerificationCodeViewController()
                verificationCodeViewController.phoneNumber.text = self.phoneNumberTextField.text
                self.navigationController?.pushViewController(verificationCodeViewController, animated: true)
            }
        }
    }
    
    
    private func sendVerificationCode(to phoneNumber: String, completion: @escaping (Error?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(error)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            completion(nil)
        }
    }
    
    private func makeBack() {
        // first layer
        let backImageView = UIImageView()
        backImageView.frame = view.bounds
        backImageView.image = .backGround
        view.addSubview(backImageView)
        view.sendSubviewToBack(backImageView)
        // second layer
        
        let positionOnX: CGFloat = 0
        let positionOnY: CGFloat = view.frame.height / 2.8
        let height:CGFloat = view.frame.height - positionOnY / 2
        let width = view.frame.width
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,y: positionOnY  ,width: width, height: height),
            cornerRadius: 50)
        roundLayer.path = bezierPath.cgPath
        roundLayer.fillColor = UIColor.white.cgColor
        view.layer.insertSublayer(roundLayer, at: 1)
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "alert1" {
            showAlert(title: "Первая ссылка", message: "Это алерт для первой ссылки")
        } else if URL.absoluteString == "alert2" {
            showAlert(title: "Вторая ссылка", message: "Это алерт для второй ссылки")
        }
        return false
    }
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var formattedPhoneNumber = "+"
        
        for (index, character) in cleanedPhoneNumber.enumerated() {
            if index == 3 || index == 5 || index == 8 || index == 10 || index == 13 {
                formattedPhoneNumber += " "
            }
            formattedPhoneNumber.append(character)
        }
        
        return formattedPhoneNumber
    }
}

extension PhoneNumberViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if text.hasPrefix("+380") && newString.count < 4 {
            return false
        }
        if newString.count > 17 {
            return false
        }
        let formattedPhoneNumber = formatPhoneNumber(newString)
        textField.text = formattedPhoneNumber
        return false
    }
}
