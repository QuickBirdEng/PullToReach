#
# Be sure to run `pod lib lint PullToReach.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PullToReach'
  s.version          = '0.1.1'
  s.summary          = 'PullToReach is a simple drag-and-drop solution for implementing pull-to-reach.'
  s.module_name      = 'PullToReach'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
PullToReach is a simple drag-and-drop solution for implementing the pull-to-reach functionality seen in the music app Soor by Tanmay. This allows your users with big phones to reach the content on the top of the display easily.
                       DESC


  s.homepage         = 'https://github.com/quickbirdstudios/PullToReach'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stefan Kofler' => 'stefan.kofler@quickbirdstudios.com' }
  s.source           = { :git => 'https://github.com/quickbirdstudios/PullToReach.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'PullToReach/Classes/**/*'
  s.frameworks = 'UIKit'
end
