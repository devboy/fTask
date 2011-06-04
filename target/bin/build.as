task("a", function(t)
{
    trace(t.task.name);
});

task("b", function(t)
{
    trace(t.task.name);
});

task("c", ["a","b"],function(t)
{
    trace(t.task.name);
}).invoke({});