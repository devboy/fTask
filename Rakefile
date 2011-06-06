ENV["REDTAMARIN_HOME"] ||= "~/Development/Libraries/RedTamarin/0.3.1.1049"
ASC_JAR = ENV["REDTAMARIN_HOME"] + "/asc.jar"
BUILTIN_ABC = ENV["REDTAMARIN_HOME"] + "/builtin.abc"
TOPLEVEL_ABC = ENV["REDTAMARIN_HOME"] + "/toplevel.abc"
GLUE_ABC = ENV["REDTAMARIN_HOME"] + "/avmglue.abc"
SRC = "src/main/as3"

FTASK="#{SRC}/ftask"
TARGET="target/bin"

desc "Build ftask.abc"
task :make_abc do
  imports = [TOPLEVEL_ABC, BUILTIN_ABC,GLUE_ABC]
  asc(["#{FTASK}.as"], imports)
end

desc "Build ftask.swf"
task :make_swf => :make_abc do
  File.delete "#{TARGET}/ftask.swf" if File.exists? "#{TARGET}/ftask.swf"
  system( "#{ENV["REDTAMARIN_HOME"]}/swfmake -o #{TARGET}/ftask.swf -c #{GLUE_ABC} #{FTASK}.abc" )
end

desc "Build exe"
task :make_exe => :make_swf do
  File.delete "#{TARGET}/ftask" if File.exists? "#{TARGET}/ftask"
  File.delete "#{TARGET}/ftask.exe" if File.exists? "#{TARGET}/ftask.exe"

  system( "#{ENV["REDTAMARIN_HOME"]}/createprojector -exe #{ENV["REDTAMARIN_HOME"]}/redshell -o #{TARGET}/ftask #{TARGET}/ftask.swf" )
  system( "#{ENV["REDTAMARIN_HOME"]}/createprojector -exe #{ENV["REDTAMARIN_HOME"]}/redshell.exe -o #{TARGET}/ftask.exe #{TARGET}/ftask.swf" )
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