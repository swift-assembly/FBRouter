#
# Be sure to run `pod lib lint JYNavigatorKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FBRouter'
  s.version          = '1.0.0'
  s.summary          = '路由组件'


  s.description      = <<-DESC
        简单易用的路由组件 
                       DESC

  s.homepage         = 'https://github.com/swift-assembly/FBRouter'
  s.license          = 'MIT'
  s.author           = { 'flywithbug' => 'flywithbug@gmail.com' }
  s.source           = { :git => 'https://github.com/swift-assembly/FBRouter.git', :tag => s.version }

  s.ios.deployment_target = "14.0"
  
  s.swift_version = '5.0'

  s.subspec 'FBRouter' do |ss|
    ss.source_files = ['FBRouter/Classes/**/*']
  end
  

end
