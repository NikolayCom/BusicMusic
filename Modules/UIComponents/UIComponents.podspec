Pod::Spec.new do |spec|
  spec.name         = "UIComponents"
  spec.version      = "0.0.1"
  spec.summary      = "UIComponents"
  spec.description  = <<-DESC
  Design module
                   DESC
  spec.homepage     = "https://nikolaypivnik.com"
  spec.license      = "BSD"
  spec.author       = { "Nikolay Pivnik" => "nikolaypivnik@gmail.com" }
  spec.platform     = :ios, "14.0"
  spec.swift_version = "5.6.1"
  spec.source       = { :path => "." }
  spec.source_files  = "UIComponents/**/*.{h,m,swift}"
  spec.frameworks = "Foundation"


  spec.dependency "Constants"
  spec.dependency "Extensions"
  spec.dependency "SnapKit"
  spec.dependency "Then"
  spec.dependency "SDWebImage"
  spec.dependency "NVActivityIndicatorView"
end
