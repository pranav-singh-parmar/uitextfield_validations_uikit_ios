# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'uitextfield-validations' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'IQKeyboardManager'

  # Pods for uitextfield-validations

  target 'uitextfield-validationsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'uitextfield-validationsUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end