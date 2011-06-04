package {
    use namespace fTaskInternal;

    public function task(name:String, ...args):FTask
    {
        args.unshift(name);
        return FTask.fTaskInternal::ROOT.task.apply(null, args);
    }
}
