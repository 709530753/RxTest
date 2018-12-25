
import UIKit
import RxSwift
import RxCocoa
class MvvmViewModel: BaseViewModel {
    
    var labelText = Variable<Int>(.init())
    private let disposeBag = DisposeBag()

    var labelText_C = Variable<Int>(.init())

    init() {
        initViewModel()
    }
    
    func initViewModel() {
        labelText.asObservable().skip(1).subscribe { [weak self] (model) in
            print("labelText : \(model)")
            self?.labelText_C.value = model.element ?? 0
        }.disposed(by: disposeBag)
    }
    
}

class MvvmViewModelType: ViewModelType {
    
    func transform(input: MvvmViewModelType.Input) -> MvvmViewModelType.Output {
        let greeting = input.password
            .withLatestFrom(input.username)
            .map { name in
                return "Hello \(name)!"
            }
            .startWith("")
            .asDriver(onErrorJustReturn: ":-(")
        
        return Output(greeting: greeting)
    }
    
    
    struct Input {
        let username: Observable<String>
        let password: Observable<Void>
    }
    
    struct Output {
        let greeting: Driver<String>
        
    }
    
}
