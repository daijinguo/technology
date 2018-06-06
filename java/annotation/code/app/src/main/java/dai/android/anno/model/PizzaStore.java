package dai.android.anno.model;


public final class PizzaStore {

    private IMealFactory mFactory = new IMealFactory();

    public IMeal order(String name) {
        return mFactory.create(name);
    }
}
