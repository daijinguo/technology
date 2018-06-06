package dai.android.anno.model;

import dai.android.annotation.Factory;

@Factory(id = "Calzone", type = IMeal.class)
public class CalzonePizza implements IMeal {
    @Override
    public float getPrice() {
        return 8F;
    }
}
