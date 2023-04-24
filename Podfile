# External

def external_pods
  
# Formatter
  pod 'SwiftLint', '~> 0.47.1'

# Constraints
  pod 'SnapKit', '~> 5.0.1'

# Load image
  pod 'SDWebImage', '~> 5.0'

# Initialization
  pod 'Then', '~> 2.7.0'

# Keyboard
  pod 'IQKeyboardManagerSwift', '~> 6.3.0'

# Notifications
  pod 'NotificationBannerSwift', '~> 3.0.0'

# Initial animation
  pod 'lottie-ios'
  pod 'Pulsator'

# Firebase
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Firestore'
  pod 'Firebase/Database'

# SignIn
  pod 'GoogleSignIn', '~> 7.0.0'

# Debug panel
  pod "DBDebugToolkit", '~> 0.8.0', :configurations => ['Debug']
  pod 'CocoaLumberjack/Swift', :configurations => ['Debug']

end

# Development

def developmet_pods
  pod "Core", :path => "./Modules/Core"
  pod "Resources", :path => "./Modules/Resources"
  pod "Constants", :path => "./Modules/Constants"
  pod "UIComponents", :path => "./Modules/UIComponents"
  pod "Extensions", :path => "./Modules/Extensions"
  pod "UseCases", :path => "./Modules/UseCases"
  pod "Auth", :path => "./Modules/Auth"
  pod "Models", :path => "./Modules/Models"
  pod "Common", :path => "./Modules/Common"
  pod "Main", :path => "./Modules/Main"
  pod "HomeBox", :path => "./Modules/HomeBox"
  pod "Profile", :path => "./Modules/Profile"
end

# Targerts
use_frameworks!
inhibit_all_warnings!

target 'BasicMusic' do
  platform :ios, '14.0'
  
  external_pods
  developmet_pods
end
