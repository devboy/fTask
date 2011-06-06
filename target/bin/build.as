import avmplus.*;
import org.devboy.ftask.*;

task("compile", function(t)
{
    FileSystem.write("compile.txt","Created by the compile task.")
}).
describe("Compile task example.");

task("clean", function(t)
{
    if(FileSystem.exists("compile.txt"))
        FileSystem.remove("compile.txt");
}).
describe("Clean task example.");

task("test",["compile"], function(t)
{
    if(FileSystem.exists("compile.txt"))
        if( FileSystem.read("compile.txt") == "Created by the compile task." )
            trace("Test passed!");
        else
            trace("Test failed!");
}).
describe("Test task example.");

task("build", ["test"]).describe("Build task example.");