# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'PillReminder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VideoSvit
  
    # Common
  pod 'SnapKit', '~> 5.6.0'
  pod 'R.swift', '~> 6.1.0'
  pod 'Kingfisher'
  pod 'ProgressHUD', '~> 13.6'
  pod 'KeychainAccess', '~> 3.2.1'
  
    # DI
  pod 'Swinject', '~> 2.6.2'
  pod 'SwinjectAutoregistration', '~> 2.6.1'

end

post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          xcconfig_path = config.base_configuration_reference.real_path
          xcconfig = File.read(xcconfig_path)
          xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
          File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
          end
      end
  end

