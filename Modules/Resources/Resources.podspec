Pod::Spec.new do |spec|
  spec.name         = "Resources"
  spec.version      = "0.0.1"
  spec.summary      = "Resources"
  spec.description  = <<-DESC
  Extensions module
                   DESC
  spec.homepage     = "https://nikolaypivnik.com"
  spec.license      = "BSD"
  spec.author       = { "Nikolay Pivnik" => "nikolaypivnik@gmail.com" }
  spec.platform     = :ios, "14.0"
  spec.swift_version = "5.6.1"
  spec.source       = { :path => "." }
  spec.source_files  = "Resources/**/*.{h,m,swift}"
  spec.resources = ["Resources/**/*.{xcassets,strings}"]

  spec.frameworks = "Foundation"
end
