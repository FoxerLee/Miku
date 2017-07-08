Pod::Spec.new do |s|
s.name             = "BMPlayer"
s.version          = "0.8.7"
s.summary          = "Video Player Using Swift, based on AVPlayer"

s.description      = <<-DESC
Video Player Using Swift, based on AVPlayer, support for the horizontal screen, vertical screen, the upper and lower slide to adjust the volume, the screen brightness, or so slide to adjust the playback progress.
DESC

s.homepage         = "https://github.com/BrikerMan/BMPlayer"

s.license          = 'MIT'
s.author           = { "Eliyar Eziz" => "eliyar917@gmail.com" }
s.source           = { :git => "https://github.com/BrikerMan/BMPlayer.git", :tag => s.version.to_s }
s.social_media_url = 'http://weibo.com/536445669'

s.ios.deployment_target = '8.0'
s.platform     = :ios, '8.0'

s.default_subspec = 'Full'

s.subspec 'Core' do |core|
    core.frameworks   = 'UIKit', 'AVFoundation'
    core.source_files = 'Source/BMPlayerLayerView.swift'
end

s.subspec 'Full' do |full|
    full.source_files = 'Source/*.swift','Source/Default/*'
    full.resources    = "Source/**/*.xcassets"
    full.frameworks   = 'UIKit', 'AVFoundation'

    full.dependency 'BMPlayer/Core'
    full.dependency 'SnapKit', '~> 3.2'
    full.dependency 'NVActivityIndicatorView', '~> 3.5'
end

s.subspec 'CacheSupport' do |cache|
    cache.source_files = 'Source/*.swift','Source/CacheSupport/*'
    cache.resources    = "Source/**/*.xcassets"
    cache.frameworks   = 'UIKit', 'AVFoundation'

    cache.dependency 'BMPlayer/Core'
    cache.dependency 'SnapKit', '~> 3.2'
    cache.dependency 'NVActivityIndicatorView', '~> 3.5'
    cache.dependency 'VIMediaCache'
end

end
