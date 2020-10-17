source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'

install! 'cocoapods', :deterministic_uuids => false

def shared_pods
  use_frameworks!
  inhibit_all_warnings!

  pod 'Unbox'
  pod 'RealmSwift', '3.17.1'
  pod 'JSONWebToken'
  pod 'Moya', '13.0.1'
  pod 'Kingfisher', '5.7.0'
end

def default_pods
  shared_pods
  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.2'
        end
        if target.name == 'JSONWebToken'
            system("rm -rf Pods/JSONWebToken/CommonCrypto")
        end
    end

    installer.pods_project.build_configurations.each do |config|
      if config.name == 'PRODUCT_RELEASE'
        config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
        config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
      end
    end

end

target 'SwiftUIDemo' do
  default_pods
end
