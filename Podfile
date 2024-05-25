platform :ios, '13.0'

target 'Bir Esnaf V2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Bir Esnaf V2

pod 'SnapKit'

pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'Firebase/Storage'
pod 'Firebase/Analytics'
pod 'FirebaseFirestoreSwift'

pod 'ProgressHUD'

pod 'IQKeyboardManagerSwift'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
/Users/seymaarslan/Desktop/swift/Bir-Esnaf-V2/Podfile
