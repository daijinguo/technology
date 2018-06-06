package dai.android.anno.model;

import dai.android.annotation.Factory;

@Factory(id = "Margherita", type = IMeal.class)
public class MargheritaPizza implements IMeal {
    @Override
    public float getPrice() {
        return 6F;
    }
}
