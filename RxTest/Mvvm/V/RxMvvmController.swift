
import UIKit
import RxCocoa
import RxSwift

class RxMvvmController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private let viewMdoel = MvvmViewModel()
    private let viewMdoelType = MvvmViewModelType()

    private let disposeBag = DisposeBag()
    
    var tabTextInt:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputs = MvvmViewModelType.Input(username: textField.rx.text.orEmpty.asObservable(), password: btn.rx.tap.asObservable())
       let outputs = viewMdoelType.transform(input: inputs)
        outputs.greeting.drive(label.rx.text).disposed(by: disposeBag)
        
        /*
        btn.rx.tap
            .subscribe({ [weak self] _ in
            print("点击了!")
                self?.tabTextInt += 1
                self?.viewMdoel.labelText.value = (self?.tabTextInt)!
                
                let vc = "ObservableController".getVC() as! ObservableController
                self?.navigationController?.pushViewController(vc, animated: true)
//                vc.subject.subscribe({ (event) in
//                    print("event : \(event.element ?? "")")
//                }).disposed(by: (self?.disposeBag)!)

                vc.subject.subscribe(onNext:{
                     print("event : \($0)")
                }).disposed(by: (self?.disposeBag)!)
                
            }).disposed(by: disposeBag)
        
        
        viewMdoel.labelText_C.asObservable().skip(1).subscribe { (event) in
            print("labelText_C : \(event.element ?? 0)")

        }.disposed(by: disposeBag)
 */
        
    }

}
