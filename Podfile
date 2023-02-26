# External

def external_pods
  
# Formatter
  pod 'SwiftLint', '~> 0.47.1'

# Constraints
  pod 'SnapKit', '~> 5.0.1'

# Loader
  pod 'NVActivityIndicatorView'

# Load image
  pod 'SDWebImage', '~> 5.0'

# Initialization
  pod 'Then', '~> 2.7.0'

# Firebase
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Crashlytics'
end

# Development

def developmet_pods
  pod "Core", :path => "./Modules/Core"
  pod "Constants", :path => "./Modules/Constants"
  pod "UIComponents", :path => "./Modules/UIComponents"
  pod "Extensions", :path => "./Modules/Extensions"
  pod "UseCases", :path => "./Modules/UseCases"
  pod "Auth", :path => "./Modules/Auth"
  pod "Resources", :path => "./Modules/Resources"
end

# Targerts
use_frameworks!
inhibit_all_warnings!

target 'BasicMusic' do
  platform :ios, '14.0'
  
  external_pods
  developmet_pods
end
