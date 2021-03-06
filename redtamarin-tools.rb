ENV["REDTAMARIN_HOME"] ||= "~/Development/Libraries/RedTamarin/0.3.1.1049"
ASC_JAR = ENV["REDTAMARIN_HOME"] + "/asc.jar"
BUILTIN_ABC = ENV["REDTAMARIN_HOME"] + "/builtin.abc"
TOPLEVEL_ABC = ENV["REDTAMARIN_HOME"] + "/toplevel.abc"
GLUE_ABC = ENV["REDTAMARIN_HOME"] + "/avmglue.abc"

def asc(asfiles, imports=[])
  cmd_args = ["java", "-jar"]
  cmd_args << ASC_JAR
  cmd_args << "-AS3" << "-strict"
  imports.each { |import| cmd_args << "-import #{import}" }
  asfiles.each { |asfile| cmd_args << "#{asfile}" }
  p "exec: " + cmd_args.join(" ")
  system cmd_args.join(" ")
end


class RTC < Buildr::Compiler::Base #:nodoc:

  specify :language => :actionscript,
          :sources => :as3, :source_ext => :as,
          :target => "bin"

  def compile(sources, target, dependencies) #:nodoc:
    source = sources[0].to_s

    unless Buildr.application.options.dryrun
      asc([File.join(source, "ftask.as")], [TOPLEVEL_ABC, BUILTIN_ABC, GLUE_ABC])
      system("#{ENV["REDTAMARIN_HOME"]}/swfmake -o #{target}/ftask.swf -c #{GLUE_ABC} #{File.join(source, "ftask.abc")}")

      File.delete "#{target}/ftask" if File.exists? "#{target}/ftask"
      File.delete "#{target}/ftask.exe" if File.exists? "#{target}/ftask.exe"

      system("#{ENV["REDTAMARIN_HOME"]}/createprojector -exe #{ENV["REDTAMARIN_HOME"]}/redshell -o #{target}/ftask #{target}/ftask.swf")
      system("#{ENV["REDTAMARIN_HOME"]}/createprojector -exe #{ENV["REDTAMARIN_HOME"]}/redshell.exe -o #{target}/ftask.exe #{target}/ftask.swf")
    end
  end

  def needed?(sources, target, dependencies)
    true
  end

end

Buildr::Compiler << RTC