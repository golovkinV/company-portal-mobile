use_frameworks!
inhibit_all_warnings!

platform :ios, '13.0'

target 'CompanyPortal' do

    #Network
    pod 'Kingfisher', '5.7.1'
    pod 'Moya/RxSwift', '14.0.0'
    pod 'netfox'
    
    #Utils
    pod 'DITranquillity', '3.7.1'
    pod 'RxSwift', '5.1.1'
    pod 'RxCocoa', '5.1.1'
    pod 'Localize-Swift', '3.0.0'
    pod 'KeychainAccess', '3.2.0'
    pod 'IQKeyboardManagerSwift', '6.2.0'
    pod 'RealmSwift', '3.21.0'
    
    #UI
    pod 'IGListKit', '3.4.0'
    pod 'InputMask', '5.0.0'
    pod 'PinLayout', '1.9.0'

    # Scripts
    pod 'SwiftGen', '~> 6.0'
    pod 'SwiftFormat/CLI', '~> 0.43.0'

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '5'
            end
        end
    end
end
