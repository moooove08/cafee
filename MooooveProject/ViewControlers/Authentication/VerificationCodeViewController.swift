
import UIKit
import Firebase

class VerificationCodeViewController: UIViewController, UITextFieldDelegate {
    var phoneNumber = UILabel()
    
    private var digitTextFields = [UITextField]()
    private let stackViewTextFields = UIStackView()
    private let verifyButton = UIButton()
    private var titleLabel = UILabel()
    private var textInformation = UILabel()
    private var backButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBack()
        setTextFields()
        setVeryfyButton()
        setLabels()
        backButtonTappedSettings()
    }
    
    
    //MARK: Selectors
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let index = digitTextFields.firstIndex(of: textField), let text = textField.text {
            if index < digitTextFields.count - 1 && text.count == 1 {
                digitTextFields[index + 1].becomeFirstResponder()
            } else if index > 0  && text.count == 0 {
                digitTextFields[index - 1].becomeFirstResponder()
            }
        }
    }
    
    @objc func verifyButtonTapped() {
        let verificationCode = digitTextFields.map { $0.text ?? "" }.joined()
        guard !verificationCode.isEmpty else {
            print("Please enter verification code")
            return
        }
        
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            print("Verification ID not found")
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error verifying phone number: \(error.localizedDescription)")
                return
            }
            
            print("Phone number verified")
            
            DispatchQueue.main.async {
                let registrationController =  RegistrationDataViewController()
                self.navigationController?.pushViewController(registrationController, animated: true)
            }
        }
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    //MARK: Labels Settings
    
    private func setLabels() {
        // title label
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        titleLabel.text = "Введіть код"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40) ,
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        //Text information label
        textInformation.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 22)
        textInformation.text = "SMS код відправлено на номер:"
        textInformation.textColor = .white
        textInformation.textAlignment = .center
        textInformation.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(textInformation)
        textInformation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textInformation.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20) ,
            textInformation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textInformation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        // phone number label
        phoneNumber.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        phoneNumber.textColor = .white
        phoneNumber.textAlignment = .center
        phoneNumber.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(phoneNumber)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: textInformation.bottomAnchor, constant: 20) ,
            phoneNumber.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            phoneNumber.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    //MARK: TextFieldSettings
    private func setTextFields() {
        
        stackViewTextFields.axis = .horizontal
        stackViewTextFields.alignment = .center
        stackViewTextFields.spacing = 10
        
        for _ in 0..<6 {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
            textField.heightAnchor.constraint(equalToConstant: 80).isActive = true
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textField.delegate = self
            textField.layer.borderColor = UIColor.border.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 20
            textField.layer.masksToBounds = true
            textField.themeChanging()
            stackViewTextFields.addArrangedSubview(textField)
            digitTextFields.append(textField)
        }
        
        view.addSubview(stackViewTextFields)
        stackViewTextFields.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewTextFields.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewTextFields.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 230),
        ])
        digitTextFields.first?.becomeFirstResponder()
    }
    
    //MARK: Buttons Settings
    private func setVeryfyButton() {
        view.addSubview(verifyButton)
        verifyButton.setTitle("Підтвердити", for: .normal)
        verifyButton.setTitleColor(.white, for: .normal)
        verifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        verifyButton.frame.size = CGSize(width: 350, height: 70)
        verifyButton.layer.cornerRadius = verifyButton.frame.height / 2
        verifyButton.layer.masksToBounds = true
        verifyButton.layer.borderWidth = 5
        verifyButton.layer.borderColor = UIColor.buttonBorder.cgColor
        verifyButton.backgroundColor = .buttonTint
        verifyButton.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verifyButton.topAnchor.constraint(equalTo: stackViewTextFields.bottomAnchor, constant: 20),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyButton.heightAnchor.constraint(equalToConstant: 70),
            verifyButton.widthAnchor.constraint(equalToConstant: 350)])
    }
    //backBarButton
    private func backButtonTappedSettings() {
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
        backButton.backButtonImageBack()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 45),
            backButton.widthAnchor.constraint(equalToConstant: 45)])
    }

    
    //MARK: BackGround Setup
    
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
  
    
    //MARK: TextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (textField.text?.count ?? 0) + string.count <= 1
    }
}
