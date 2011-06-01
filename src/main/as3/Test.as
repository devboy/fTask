package
{

    import flash.display.Shape;
    import flash.display.Sprite;

    import org.devboy.ftask.task;

    public class Test extends Sprite
    {
        public function Test()
        {
            var shape:Shape = new Shape();

            task("paintShape", function(t)
            {
                shape.graphics.beginFill(t.color);
                shape.graphics.drawRect(0, 0, 100, 100);
                shape.graphics.endFill();
            });

            task("addShape", function(t)
            {
                addChild(shape);
            });

            task("rotateShape", ["addShape","paintShape"], function(t)
            {
                shape.rotation = 29;
            }).invoke({color:0x0000FF});



        }
    }
}
