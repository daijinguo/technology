package dai.android.anno.model;

import dai.android.annotation.Factory;

@Factory(id = "Tiramisu", type = IMeal.class)
public class Tiramisu implements IMeal {
    @Override
    public float getPrice() {
        return 7.5F;
    }
}
