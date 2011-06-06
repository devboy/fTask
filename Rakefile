ENV["REDTAMARIN_HOME"] ||= "~/Development/Libraries/RedTamarin/redtamarin_0.3.1.1049_OSX"
ASC_JAR = ENV["REDTAMARIN_HOME"] + "/asc.jar"
BUILTIN_ABC = ENV["REDTAMARIN_HOME"] + "/builtin.abc"
TOPLEVEL_ABC = ENV["REDTAMARIN_HOME"] + "/toplevel.abc"
SRC = "src/main/as3"

FTASK="#{SRC}/ftask"
GLUE="lib/main/as3/avmglue_0.1.0.2305/avmglue"
TARGET="target/bin"

desc "Build ftask.abc"
task :make_abc do
  imports = [TOPLEVEL_ABC, BUILTIN_ABC,"#{GLUE}.abc"]
  asc(["#{FTASK}.as"], imports)
end

desc "Build ftask.swf"
task :make_swf => :make_abc do
  system( "#{ENV["REDTAMARIN_HOME"]}/swfmake -o #{TARGET}/ftask.swf -c #{GLUE}.abc #{FTASK}.abc" )
end

desc "Build exe"
task :make_exe => :make_swf do
  system( "#{ENV["REDTAMARIN_HOME"]}/createprojector -exe #{ENV["REDTAMARIN_HOME"]}/redshell -o #{TARGET}/ftask #{TARGET}/ftask.swf" )
end

desc "build abc files"
task :build => [:make_exe] do
end

def asc(asfiles, imports=[])
  cmd_args = ["java", "-jar"]
  cmd_args << ASC_JAR
  cmd_args << "-AS3" << "-strict"
  imports.each { |import| cmd_args << "-import #{import}" }
  asfiles.each { |asfile| cmd_args << "#{asfile}" }
  p "exec: " + cmd_args.join(" ")
  system cmd_args.join(" ")
end