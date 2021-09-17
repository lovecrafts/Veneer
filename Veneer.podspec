#
# Be sure to run `pod lib lint Veneer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Veneer'
  s.version          = '0.1.0'
  s.summary          = 'Overlay helper library'

  s.description      = <<-DESC

    A helper library for adding overlays on top of iOS screens. Used on the LoveKnitting app to show helper / walkthrough overlays.

                       DESC

  s.homepage         = 'https://github.com/lovecrafts/Veneer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sam Watts' => 'sam.watts@loveknitting.com' }
  s.source           = { :git => 'https://github.com/lovecrafts/Veneer', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'Veneer/Classes/**/*'

  s.frameworks = 'UIKit'

end
