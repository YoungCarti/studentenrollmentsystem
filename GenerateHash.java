import org.mindrot.jbcrypt.BCrypt;

public class GenerateHash {
    public static void main(String[] args) {
        String adminPassword = "admin123";
        String reshPassword = "resh123";
        String studentPassword = "student123";
        
        String adminHash = BCrypt.hashpw(adminPassword, BCrypt.gensalt(10));
        String reshHash = BCrypt.hashpw(reshPassword, BCrypt.gensalt(10));
        String studentHash = BCrypt.hashpw(studentPassword, BCrypt.gensalt(10));
        
        System.out.println("Admin (admin123) hash: " + adminHash);
        System.out.println("Resh (resh123) hash: " + reshHash);
        System.out.println("Student (student123) hash: " + studentHash);
    }
}
