package dai.android.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.CLASS)
public @interface Factory {

    /**
     * the name of factory
     */
    Class type();


    /**
     * the identifier for determining which item should be instantiated
     */
    String id();

}
