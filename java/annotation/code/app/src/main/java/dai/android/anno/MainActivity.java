package dai.android.anno;

import android.app.Activity;
import android.os.Bundle;

import dai.android.anno.model.IMeal;
import dai.android.anno.model.PizzaStore;
import dai.android.anno.model.myData;
import dai.android.annotation.JPHelloWorld;

//@MyAnnotation("This is self annotation")
@JPHelloWorld
public class MainActivity extends Activity {

    private myData mData;
    private PizzaStore mStore;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        mData = new myData(myData.STATUS_OPEN);
        //mData = new myData(myData.STATUS_OPEN);
        mStore = new PizzaStore();
    }

    public IMeal orderMeal(String name) {
        return null;
    }
}
