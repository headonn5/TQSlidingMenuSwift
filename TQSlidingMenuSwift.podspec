Pod::Spec.new do |s|

  

  s.name         = "TQSlidingMenuSwift"
  s.version      = "1.0.2"
  s.summary      = "Gmail like sliding menu written in swift 3.0.2"
  s.description  = <<-DESC "The Sliding menu which is the same as GMail iOS app sliding menu, can be used in the apps that wants to make use of non-conventional sliding menu."
                   DESC
  s.homepage     = "https://deepdivers.wordpress.com/portfolio/tqslidingmenuswift/"
  s.screenshots  = "https://deepdivers.files.wordpress.com/2017/03/tqslidingmenudemo.gif"
  s.license      = "MIT"
  s.author       = "Nishant"
  s.platform     = :ios, "8.0"
  s.source       = {:git => "https://github.com/headonn5/TQSlidingMenuSwift.git", :tag => s.version}
  s.source_files  = "TQSlidingMenuSwift", "TQSlidingMenuSwift/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0.2' }

end
