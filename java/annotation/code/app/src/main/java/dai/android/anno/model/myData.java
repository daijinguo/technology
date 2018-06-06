package dai.android.anno.model;

import android.support.annotation.IntDef;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

public class myData {

    public static final int STATUS_UNKNOWN = 0;
    public static final int STATUS_OPEN = 1;
    public static final int STATUS_CLOSE = 2;

    @IntDef({STATUS_UNKNOWN, STATUS_OPEN, STATUS_CLOSE})
    @Retention(RetentionPolicy.SOURCE)
    @Target(ElementType.PARAMETER)
    public @interface Status {
    }

    private int mStatus = STATUS_UNKNOWN;

    public void setStatus(@Status int status) {
        mStatus = status;
    }

    public int getStatus() {
        return mStatus;
    }

    public myData() {
        this(STATUS_UNKNOWN);
    }

    public myData(@Status int status) {
        setStatus(status);
    }

}
