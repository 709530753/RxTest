
import UIKit

protocol ViewModel {
    
    func initViewModel()
    
}

protocol ViewModelType {

    associatedtype Input
    
    associatedtype Output
    
    func transform(input: Input) -> Output


}
