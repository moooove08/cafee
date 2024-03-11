//
//  RegistrationDataViewController.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 04.03.2024.
//

import UIKit
import Firebase

class EditPersonalDataViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var cityTextField: CustomTextField!
    @IBOutlet var dateBirthtextField: CustomTextField!
    @IBOutlet var buttonSave: UIButton!
    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var nothingButton: UIButton!
    @IBOutlet var womanButton: UIButton!
    @IBOutlet var manButton: UIButton!
    
    private let birthdayPiker =  UIDatePicker()
    private let cityPicker = UIPickerView()
    private let cityInfo = RegistrationData()
    private var activeTextField: UITextField?
    private var backButton = UIButton()
    private let dataBase = Database.database().reference()
    private let currentUser = Auth.auth().currentUser
    private var selectedOptionIndex: Int? {
        didSet {
            updateOptionsUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        gestureRecognizer()
        makeBack()
        notificationCenter()
        pickersSetup()
        textFieldsSetup()
        createOptionButtons()
        saveButtonSettings()
        backButtonTappedSettings()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func buttonTupped(_ sender: UIButton) {
        if let buttonIndex = buttonStackView.arrangedSubviews.firstIndex(of: sender) {
            selectedOptionIndex = buttonIndex
        }
    }
    
    @IBAction func saveUserData(_ sender: Any) {
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        UserDefaults.standard.set(cityTextField.text, forKey: "city")
        saveDataUser()
    }
    
    
    //MARK: Selectors
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        if let mindate = birthdayPiker.minimumDate, let maxdate = birthdayPiker.maximumDate  {
            if sender.date < mindate {
                sender.date = birthdayPiker.date
            } else if sender.date > maxdate {
                sender.date = birthdayPiker.date
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateBirthtextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3
            if let activeField = activeTextField {
                if activeField == nameTextField {
                    let keyboardHeight = keyboardSize.height / 5.5
                UIView.animate(withDuration: duration) {
                    self.view.frame.origin.y = -keyboardHeight
                }
                }else {
                    self.view.frame.origin.y = 0
                }
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3
        
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = 0
        }
    }
    @objc func returnToView() {
        cityTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        dateBirthtextField.resignFirstResponder()
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    private func gestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(returnToView))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func notificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: TextFields setup
    
    private func textFieldsSetup() {
        // date of birth textField
        if let savedValue = UserDefaults.standard.object(forKey: "dateOfBirth") as? String {
            dateBirthtextField.text = savedValue
        }
        dateBirthtextField.inputView = birthdayPiker
        dateBirthtextField.delegate = self
        dateBirthtextField.settingsTextField()
        dateBirthtextField.addDoneButton()
        dateBirthtextField.setRightView(.ccalendar)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        // city textField
        if let savedValue = UserDefaults.standard.object(forKey: "city") as? String {
            cityTextField.text = savedValue
        }
        cityTextField.inputView = cityPicker
        cityTextField.delegate = self
        cityTextField.settingsTextField()
        cityTextField.addDoneButton()
        cityTextField.setRightView(.arrows)
       
        
        //name textfield
        if let savedValue = UserDefaults.standard.object(forKey: "name") as? String {
            nameTextField.text = savedValue
        }
        nameTextField.delegate = self
        nameTextField.settingsTextField()
        nameTextField.addDoneButton()
        
    }
    //MARK: City and Date Pickers
    private func pickersSetup() {
        // birthday picker
        
        birthdayPiker.datePickerMode = .date
        birthdayPiker.preferredDatePickerStyle = .wheels
        let currentDate = Date()
        let calendar = Calendar.current
        let minDate = calendar.date(byAdding: .year, value: -80, to: currentDate)
        let maxDate = calendar.date(byAdding: .year, value: -14, to: currentDate)
        birthdayPiker.minimumDate = minDate
        birthdayPiker.maximumDate = maxDate
        birthdayPiker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        //cityPiker
        cityPicker.dataSource = self
        cityPicker.delegate = self
    }
    //MARK: Make BackGround for View
    private func makeBack() {
        // first layer
        let backImageView = UIImageView()
        backImageView.frame = view.bounds
        backImageView.image = .backGround
        view.addSubview(backImageView)
        view.sendSubviewToBack(backImageView)
        // second layer
        
        let positionOnX: CGFloat = 0
        let positionOnY: CGFloat = view.frame.height / 4.0
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
    
    //MARK: Settings All Buttons
    private func saveButtonSettings() {
        buttonSave.layer.masksToBounds = true
        buttonSave.layer.cornerRadius = buttonSave.frame.height / 2
        buttonSave.layer.borderWidth = 5
        buttonSave.layer.borderColor = UIColor.buttonBorder.cgColor
        buttonSave.setTitleColor(UIColor.white, for: .normal)
        buttonSave.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        buttonSave.setTitle("Зберегти", for: .normal)
        buttonSave.backgroundColor = .buttonTint
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20)
        ]
        let attributedString = NSAttributedString(string: "Зберегти", attributes: attributes)
        buttonSave.setAttributedTitle(attributedString, for: .normal)
    }
    
   private func createOptionButtons() {
        for (index, optionText) in cityInfo.sexInformation.enumerated() {
            
            let button = buttonStackView.arrangedSubviews[index] as! UIButton
            
            button.setTitle("  "+optionText, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.setTitleColor(.black, for: .normal)
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
            if index == 0 {
                button.setImage(UIImage(systemName: "record.circle", withConfiguration: symbolConfiguration), for: .normal)
                
                button.tintColor = .buttonTint
            } else {
                button.setImage(UIImage(systemName: "circle.fill", withConfiguration: symbolConfiguration), for: .normal)
                button.tintColor = .border
            }
        }
    }
    
   private func updateOptionsUI() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        for (index, arrangedSubview) in buttonStackView.arrangedSubviews.enumerated() {
            if let button = arrangedSubview as? UIButton {
                if index == selectedOptionIndex {
                    button.setImage(UIImage(systemName: "record.circle", withConfiguration: symbolConfiguration), for: .normal)
                    button.tintColor = .buttonTint
                } else {
                    button.setImage(UIImage(systemName: "circle.fill", withConfiguration: symbolConfiguration), for: .normal)
                    button.tintColor = .border
                }
            }
        }
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
    
   
    private func saveDataUser() {
        if let user = currentUser {
            let userData: [String: Any] = [
                "name": nameTextField.text ?? "" ,
                "city": cityTextField.text ?? "",
            ]
            
            dataBase.child("users").child(user.uid).setValue(userData) { error, _ in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added")
                }
            }
        }
    }
}


// MARK: PickerView Extension DataSourse, Delegate
extension EditPersonalDataViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cityInfo.arrayCitys.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0: return cityInfo.arrayCitys[0]
        case 1: return cityInfo.arrayCitys[1]
        case 2: return cityInfo.arrayCitys[2]
        case 3: return cityInfo.arrayCitys[3]
        default:
            return  cityInfo.arrayCitys[0]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityTextField.text = cityInfo.arrayCitys[row]
        
    }
}


// MARK: TextField Extension DataSourse, Delegate

extension EditPersonalDataViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        buttonStackView.isHidden = true
        activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonStackView.isHidden = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if activeTextField == dateBirthtextField && dateBirthtextField.text == "" {
            dateBirthtextField.text = dateFormatter.string(from: birthdayPiker.date)
        }
        if activeTextField == cityTextField && cityTextField.text == "" {
            cityTextField.text = cityInfo.arrayCitys[0]
        }
    }
}

