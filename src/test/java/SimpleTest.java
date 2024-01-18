import org.junit.Assert;
import org.junit.Test;

public class SimpleTest {

    @Test
    public void testAddition() {
        int a = 5;
        int b = 10;
        int result = a + b;
        Assert.assertEquals("The addition result is incorrect", 15, result);
    }
}
