package org.devboy.ftask{

    import flash.utils.getQualifiedClassName;

    public class FTask
    {
        fTaskInternal static const ROOT:FTask = new FTask("root");

        private var _name:String;
        private var _dependencies:Array;
        private var _closure:Function;
        private var _taskVars:Object;
        private var _tasks:Array;
        private var _description:String;

        public function FTask(name:String)
        {
            _name = name;
            init();
        }

        private function init():void
        {
            _tasks = [];
            _dependencies = [];
        }

        public function task(name:String, ...args):FTask
        {
            var task:FTask = fTaskInternal::getTask(name);
            parseArguments(task,args);
            return task;
        }

        private function parseArguments( task:FTask, args:Array ) : void
        {
            var arg:*;
            for each(arg in args)
            {
                switch (getQualifiedClassName(arg))
                {
                    case "Array":
                        var tasks:Array = [];
                        var taskName:String;
                        for each(taskName in arg)
                            tasks.push(fTaskInternal::getTask(taskName));
                        task.fTaskInternal::addDependencies(tasks);
                        break;
                    case "String":
                        task.fTaskInternal::addDependency(fTaskInternal::getTask(arg));
                        break;
                    case "Object":
                        task.fTaskInternal::setTaskVars(arg);
                        break;
                    case "Function":
                        task.fTaskInternal::setClosure(arg);
                        break;
                }
            }
        }

        fTaskInternal function getAllTasks():Array
        {
            var tasks:Array=[];
            var ftask:FTask;
            for each( ftask in _tasks )
               tasks = tasks.concat(ftask.fTaskInternal::getAllTasks());
            return _tasks;
        }

        fTaskInternal function getTask(name:String):FTask
        {
            var task:FTask=this;
            var taskNames:Array=name.split(":");
            var taskName:String;
            for each( taskName in taskNames )
                task = task.fTaskInternal::getTaskByName(taskName);
            return task;
        }

        fTaskInternal function getTaskByName(name:String):FTask
        {
            var task:FTask;
            for each(task in _tasks)
                if (task.name == name)
                    return task;
            return createTask(name);
        }

        private function createTask(name:String):FTask
        {
            var task:FTask = new FTask(name);
            _tasks.push(task);
            return task;
        }

        fTaskInternal function addDependency(task:FTask):void
        {
            var depTask:FTask;
            for each(depTask in _dependencies)
                if (depTask == task)
                    return;
            _dependencies.push(task);
        }

        fTaskInternal function addDependencies(tasks:Array):void
        {
            var task:FTask;
            for each(task in tasks)
                fTaskInternal::addDependency(task);
        }

        fTaskInternal function setClosure(closure:Function):void
        {
            _closure = closure;
        }

        public function describe( description:String ) : FTask
        {
            _description = description;
            return this;
        }

        public function invoke( runVars:Object ):FTask
        {
            invokeDependencies(runVars);
            invokeClosure(runVars);
            return this;
        }

        private function invokeClosure(runVars:Object):void
        {
            if (_closure != null)
                _closure(createVars(runVars,_taskVars));
        }

        private function invokeDependencies(runVars:Object):void
        {
            var task:FTask;
            for each(task in _dependencies)
                task.invoke(runVars);
        }

        public function get name():String
        {
            return _name;
        }

        fTaskInternal function setTaskVars(taskVars:Object):void
        {
            _taskVars = taskVars;
        }

        private function createVars( runVars:Object, taskVars:Object ) : Object
        {
            var vars:Object = {task:this};
            if(taskVars)
                mergeVars(vars,taskVars);
            if(runVars)
                mergeVars(vars,runVars);
            return vars;
        }

        private function mergeVars( target:Object, source:Object ) : Object
        {
            var param:String;
            for( param in source)
                target[param] = source[param];
            return target;
        }

        public function get description():String
        {
            return _description || "No description.";
        }
    }
}