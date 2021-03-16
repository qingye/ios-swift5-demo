
Pod::Spec.new do |s|
  s.name             = 'CircleProgressView'
  s.version          = '1.0.0'
  s.summary          = 'A View Component for CountDown'

  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC

  s.homepage         = 'https://github.com/qingye/ios-swift-demo/CircleProgressView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '青叶小小' => '24854015@qq.com' }
  s.source           = { :git => 'https://github.com/qingye/ios-swift-demo/CircleProgressView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/*.swift'

end
