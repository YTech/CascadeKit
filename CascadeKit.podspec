Pod::Spec.new do |s|
  s.name             = 'CascadeKit'
  s.version          = '1.2.2'
  s.summary          = 'Kit to manage Cascade Styles on UIKit text controls'
  s.swift_version    = "4.0"
  s.description      = <<-DESC
Kit to manage Cascade Styles on UIKit text controls
                       DESC

  s.homepage         = 'https://github.com/YTech/CascadeKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors           = { 'Daniele Bogo' => 'me@bogodaniele.com',
                          'Ennio Masi' => 'ennio.masi@ynap.com' }
  s.source           = { :git => 'https://github.com/YTech/CascadeKit', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'CascadeKit/Source/**/*'
end
