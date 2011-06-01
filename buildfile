require 'buildr/as3'

FLEX_SDK = FlexSDK.new("4.5.0.20967")
FLEX_SDK.default_options << "-compiler.incremental=true" << "-static-link-runtime-shared-libraries=true"

define "fTask" do
  project.version = "1.0.0-SNAPSHOT"

  compile.using :mxmlc
  compile.options[:flexsdk] = FLEX_SDK
  compile.options[:main] = _(:src,:main,:as3,"Test.as")
  package :swf

  doc.options[:flexsdk] = FLEX_SDK
end