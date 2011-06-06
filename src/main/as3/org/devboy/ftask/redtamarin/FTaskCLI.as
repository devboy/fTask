package org.devboy.ftask.redtamarin
{

    import avmplus.FileSystem;
    import avmplus.System;

    import org.devboy.ftask.FTask;
    import org.devboy.ftask.fTaskInternal;

    import org.devboy.ftask.task;

    public class FTaskCLI
    {
        private const DEFAULT_BUILDFILE:String = "build.as";
        private const HELP:String =
                "fTask\n" +
                "Usage: ftask [-f buildfile] [task]\n" +
                "Options:\n" +
                "-help: Prints this screen." +
                "-T: Prints all available tasks.";

        public function FTaskCLI(argv:Array)
        {
            parseArgs(argv);
        }

        private function parseArgs(argv:Array):void
        {
            var buildfile:String = "";
            var taskName:String = "";
            var arg:String = "";
            var i:int = 0;
            const l:int = argv.length;
            for (; i < l; i++)
            {
                arg = argv[i];
                if (arg == "-help")
                {
                    trace(HELP);
                }
                else if (arg == "-T")
                {
                    printAllTasks();
                }
                else if (arg == "-f")
                {
                    buildfile = argv[i + 1];
                    i++;
                }
                else
                {
                    taskName = arg;
                }
            }

            buildfile = buildfile == "" ? DEFAULT_BUILDFILE : buildfile;

            var absBuildfile:String = FileSystem.absolutePath(buildfile);
            if (!FileSystem.exists(absBuildfile))
            {
                trace( "Could not find buildfile: " + absBuildfile );
                System.exit(1);
            }

            System.eval(FileSystem.read(absBuildfile));

            if( taskName != "" )
                task(taskName);
        }

        private function printAllTasks():void
        {
            var ftask:FTask;
            for each( ftask in FTask.fTaskInternal::ROOT.fTaskInternal::getAllTasks() )
                trace( ftask.name + ":\t" + ftask.description );
        }
    }
}
