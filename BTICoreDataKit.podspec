Pod::Spec.new do |spec|
  spec.name         = 'BTICoreDataKit'
  spec.version      = '1.0.1'
  spec.summary      = 'A handful of helpful classes and categories for iOS Core Data development.'
  spec.homepage     = 'https://github.com/BriTerIdeas/BTICoreDataKit'
  spec.author       = { 'Brian Slick' => 'brianslick@mac.com' }
  spec.source       = { :git => 'https://github.com/BriTerIdeas/BTICoreDataKit.git', :tag => "1.0.1" }
  spec.description  = 'A handful of helpful classes and categories for iOS Core Data development.'
  spec.source_files = 'BTICoreDataKit/*.{h,m}', 'BTICoreDataKit/**/*.{h,m}'
  spec.requires_arc = true
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.frameworks = 'Foundation', 'UIKit', 'CoreData'
end