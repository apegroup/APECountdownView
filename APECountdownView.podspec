Pod::Spec.new do |s|
  s.name             = "APECountdownView"
  s.summary          = "Wanna countdown to something? Then you have come to the right place!"
  s.version          = "0.1.2"
  s.homepage         = "https://github.com/apegroup/APECountdownView"
  s.license          = 'MIT'
  s.author           = { "apegroup AB" => "support@apegroup.com" }
  s.source           = { :git => "https://github.com/apegroup/APECountdownView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/apegroup'
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'Source/**/*'
  s.resources        = ['Resources/**/*']
  s.frameworks       = 'UIKit'
  s.dependency 'RxSwift', '~> 4.4'
end
