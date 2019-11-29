# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

def general_pods
  pod 'SwifterSwift', '~> 4.6.0'
  pod 'Moya'
  pod 'RxSwift', '~> 4.5.0'
  pod 'RxCocoa', '~> 4.5.0'
end

def ui_alerts_pods
  pod 'SwiftEntryKit', '~> 1.0.1'
  pod 'SwiftMessages', '~> 6.0.2'
  pod 'PKHUD', '~> 5.3.0'
end

def utilities_pods
  pod 'SwiftLocation'
  pod 'SwiftKeychainWrapper'
  pod 'AlamofireNetworkActivityLogger'
end

def all_pods
  general_pods
  ui_alerts_pods
  utilities_pods
end 

target 'Cognitev-Task' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  all_pods
end

target 'Cognitev-TaskTests' do
  inherit! :search_paths
  all_pods
end

target 'Cognitev-TaskUITests' do
    # Pods for testing
end
