#
# Be sure to run `pod lib lint PinchableLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PinchableLabel"
  s.version          = "0.1.6"
  s.summary          = "You can pinch a label."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
You can rotate and scale this label by pinching.
                       DESC

  s.homepage         = "https://github.com/malt03/PinchableLabel"
  s.screenshots      = "https://raw.githubusercontent.com/malt03/PinchableLabel/master/screen_shot.gif"
  s.license          = 'MIT'
  s.author           = { "Koji Murata" => "malt.koji@gmail.com" }
  s.source           = { :git => "https://github.com/malt03/PinchableLabel.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PinchableLabel' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
