import avmplus.System;
import avmplus.FileSystem;

import flash.system.System;

include "org/devboy/ftask/fTaskInternal.as";
include "org/devboy/ftask/FTask.as";
include "org/devboy/ftask/task.as";

var argc:uint = System.argv.length;
var argv:Array = System.argv;

if (argc != 1)
{
    trace("You need to specify a buildfile!");
    System.exit(1);
}
else
{
    var file:String = argv[0];
    var absolute:String = FileSystem.absolutePath(file);
    if (!FileSystem.exists(absolute))
    {
        trace("file \"" + file + "\" does not exists.");
        System.exit(1);
    }

    System.eval( FileSystem.read(absolute));
    System.exit(0);
}