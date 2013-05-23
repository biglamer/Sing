/**
 * Простая реализация сингелтона
 * @author Andrei
 *
 */
public class Singelton {
      // Private constructor prevents instantiation from other classes
    private Singelton() {
        barans=1;
    }
    private static class SingeltonHolder {
        public static final Singelton INSTANCE = new Singelton();
      }

      public static Singelton getInstance() {
        return SingeltonHolder.INSTANCE;
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
