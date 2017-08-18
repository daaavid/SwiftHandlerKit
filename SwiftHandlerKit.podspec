#
# Be sure to run `pod lib lint SwiftHandlerKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftHandlerKit'
  s.version          = '1.0.1'
  s.summary          = 'Elegantly assign closure-based actions to UIControls and the like.'
  s.homepage         = 'https://github.com/daaavid/SwiftHandlerKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'David Johnson' => 'david@bronze5.net' }
  s.source           = { :git => 'https://github.com/daaavid/SwiftHandlerKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'SwiftHandlerKit/**/*'
  s.frameworks = 'UIKit'
end
