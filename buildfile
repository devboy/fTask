require 'buildr/as3'

FLEX_SDK = FlexSDK.new("4.5.0.20967")
FLEX_SDK.default_options << "-compiler.incremental=true" << "-static-link-runtime-shared-libraries=true"

define "fTask" do
  project.version = "0.0.1-SNAPSHOT"

  define "Library" do
    compile.using :compc
    compile.options[:flexsdk] = FLEX_SDK
    package :swc
  end

  define "CLI" do
    #setting javac to prevent compilation
    compile.using :javac
  end

  doc.options[:flexsdk] = FLEX_SDK
end