import RxSwift
import SkyFloatingLabelTextField

// MARK: - Class

final public class AppTextField: SkyFloatingLabelTextField {
    
    // MARK: - Initializers
    
    let disposeBag = DisposeBag()
    
    public var maxLenght = -1
    
    public init(label: String = "", type: UIKeyboardType? = .default, maxLenght: Int = -1) {
        super.init(frame: .zero)
       
        lineColor = Colors.moe.color
        selectedLineColor = Colors.moe.color
        
        if(label.isEmpty) {
            lineColor = .white
            selectedLineColor = .white
        }
        
        titleColor = Colors.moe.color.withAlphaComponent(0.5)
        selectedTitleColor = Colors.moe.color.withAlphaComponent(0.5)
        titleFormatter = { $0 }
        placeholderColor = Colors.moe.color
        placeholder = label
        titleFont = FontFamily.OpenSans.semiBold.font(size: 14.0)
        self.maxLenght = maxLenght
        borderStyle = .none
        font = FontFamily.OpenSans.semiBold.font(size: 16.0)
        autocapitalizationType = .none
        
        accessibilityLabel = label
        
        if let type = type {
            keyboardType = type
        }
        
        setupRx()
    }
    
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRx() {
        rx
        .controlEvent([.editingChanged])
        .asObservable()
        .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if(self.maxLenght != -1) {
                self.verifyLength()
            }            
        }).disposed(by: disposeBag)
    }
    
    private func verifyLength() {
        if let text = self.text, text.count > maxLenght {
            self.text = String(text.dropLast(text.count - maxLenght))
            resignFirstResponder()
            return
        } else if let text = self.text, text.count == maxLenght {
            resignFirstResponder()
        }
    }
}
