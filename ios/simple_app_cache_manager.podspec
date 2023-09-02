#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint simple_app_cache_manager.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'simple_app_cache_manager'
  s.version          = '0.0.2'
  s.summary          = 'A Flutter package for managing application cache efficiently'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/therasuldev/simple_app_cache_manager'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'R2 TEAM' => 'rasul.ramixanov@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'NO', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
