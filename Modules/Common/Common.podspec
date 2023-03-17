Pod::Spec.new do |spec|
  spec.name         = "Common"
  spec.version      = "0.0.1"
  spec.summary      = "Common"
  spec.description  = <<-DESC
  Design module
                   DESC
  spec.homepage     = "https://nikolaypivnik.com"
  spec.license      = "BSD"
  spec.author       = { "Nikolay Pivnik" => "nikolaypivnik@gmail.com" }
  spec.platform     = :ios, "14.0"
  spec.swift_version = "5.6.1"
  spec.source       = { :path => "." }
  spec.source_files  = "Common/**/*.{h,m,swift}"

  spec.frameworks = "Foundation"

  spec.dependency "Core"
  spec.dependency "UseCases"
end
