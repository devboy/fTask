ENV["REDTAMARIN_HOME"] ||= "~/Development/Libraries/RedTamarin/redtamarin_0.3.1.1049_OSX/"
ASC_JAR = ENV["REDTAMARIN_HOME"] + "/asc.jar"
BUILTIN_ABC = ENV["REDTAMARIN_HOME"] + "/builtin.abc"
TOPLEVEL_ABC = ENV["REDTAMARIN_HOME"] + "/toplevel.abc"
SRC = "src/main/as3"

FTASKINTERNAL="#{SRC}/org/devboy/ftask/fTaskInternal"
FTASK="#{SRC}/org/devboy/ftask/ftask"
TASK="#{SRC}/org/devboy/ftask/task"
GLUE="lib/main/as3/avmglue_0.1.0.2305/avmglue"

desc "Build ftask.abc"
task :ftask do
  imports = [TOPLEVEL_ABC, BUILTIN_ABC,"#{GLUE}.abc"]
  asc("#{FTASK}.as", imports)
end

desc "build abc files"
task :build_abc => [:ftask] do
end

def asc(target, imports=[])
  cmd_args = ["java", "-jar"]
  cmd_args << ASC_JAR
  imports.each { |import| cmd_args << "-import #{import}" }
  cmd_args << target
  system cmd_args.join(" ")
end