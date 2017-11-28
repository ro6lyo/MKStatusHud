#
# Be sure to run `pod lib lint MKStatusHud.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKStatusHud'
  s.version          = '0.6.0'
  s.summary          = 'A Swift based reimplementation of the Apple HUD and added natively rendered After Effects vector animations.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A Swift based reimplementation of the Apple HUD and added natively rendered After Effects vector animations.You Just need to provide a JSON animaiton or images to present.'

  s.homepage         = 'https://github.com/ro6lyo/MKStatusHud'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ro6lyo' => 'roshlyo@icloud.com' }
  s.source           = { :git => 'https://github.com/ro6lyo/MKStatusHud.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<ro6lyo>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MKStatusHud/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MKStatusHud' => ['MKStatusHud/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'lottie-ios'
end
