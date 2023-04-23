Pod::Spec.new do |spec|
  spec.name         = "HomeBox"
  spec.version      = "0.0.1"
  spec.summary      = "HomeBox"
  spec.description  = <<-DESC
  Design module
                   DESC
  spec.homepage     = "https://nikolaypivnik.com"
  spec.license      = "BSD"
  spec.author       = { "Nikolay Pivnik" => "nikolaypivnik@gmail.com" }
  spec.platform     = :ios, "14.0"
  spec.swift_version = "5.6.1"
  spec.source       = { :path => "." }
  spec.source_files  = "HomeBox/**/*.{h,m,swift}"

  spec.frameworks = "Foundation"

  spec.dependency "Core"
  spec.dependency "Common"
  spec.dependency "UseCases"
  spec.dependency "Resources"
  spec.dependency "Models"

  spec.dependency "lottie-ios"
  spec.dependency "Pulsator"
end
