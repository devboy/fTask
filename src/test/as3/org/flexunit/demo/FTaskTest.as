package org.flexunit.demo
{

    import org.devboy.ftask.FTask;
    import org.devboy.ftask.task;
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;

    public class FTaskTest
    {
        [Test]
        public function createTask():void
        {
            var task:FTask=task("createTask");
            assertNotNull("createTask",task);
            assertEquals("createTaskEquals",task.name,"createTask");
        }
    }
}