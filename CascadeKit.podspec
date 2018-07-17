Pod::Spec.new do |s|
  s.name             = 'CascadeKit'
  s.version          = '1.0.0'
  s.summary          = 'Kit to manage Cascade Styles on UIKit text controls'

  s.description      = <<-DESC
Kit to manage Cascade Styles on UIKit text controls
                       DESC

  s.homepage         = 'https://github.com/YTech/CascadeKit'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.authors           = { 'Daniele Bogo' => 'me@bogodaniele.com',
                          'Ennio Masi' => 'ennio.masi@gmail.com' }
  s.source           = { :git => 'https://github.com/YTech/CascadeKit', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'CascadeKit/**/*'
end
