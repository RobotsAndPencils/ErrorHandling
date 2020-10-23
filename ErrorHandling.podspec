Pod::Spec.new do |spec|
  spec.name         = "ErrorHandling"
  spec.version      = "0.1.0"
  spec.summary      = "An easy way to thoroughly handle errors in SwiftUI, with support for retry/recovery and sign out."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  An easy way to thoroughly handle errors in SwiftUI, with support for retry/recovery and sign out.

  It's too easy to make error handling an afterthought, and this library makes it easy to add functionality that your users expect when things don't go as planned.
                   DESC

  spec.homepage     = "https://github.com/RobotsAndPencils/ErrorHandling"
  spec.license      = "MIT"
  spec.authors      = { "Brandon Evans" => "brandon.evans@robotsandpencils.com" }

  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "10.15"
  spec.watchos.deployment_target = "6.0"
  spec.tvos.deployment_target = "13.0"

  spec.source       = { :git => "git@github.com:RobotsAndPencils/ErrorHandling.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*"
  # spec.frameworks = "SomeFramework", "AnotherFramework"
end
