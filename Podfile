# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'Rappi iOS Test' do

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Realm'
  pod 'RealmSwift'
  pod 'AFNetworking'
  pod 'Alamofire', '~> 4.8.2'
  pod "youtube-ios-player-helper"
  # Pods for Rappi iOS Test

  target 'Rappi iOS TestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Rappi iOS TestUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5'
        end
    end
end


