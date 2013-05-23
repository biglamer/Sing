/**
 * Простая реализация сингелтона
 * @author Andrei
 *
 */
public class Singelton {
    private static final Singelton INSTANCE = new Singelton();
    // Private constructor prevents instantiation from other classes
    private Singelton() {
        barans=1;
    }
    public static Singelton getInstance() {
        return INSTANCE;
    }
    private int barans;
    public static void main(String[] args) {
        Singelton sing=Singelton.getInstance();
        System.out.println("barans="+sing.getBarans());
    }
    public int getBarans() {
        return barans;
    }
    public void setBarans(int barans) {
        this.barans = barans;
    }


}
