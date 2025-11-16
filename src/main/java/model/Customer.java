package model;

public class Customer {
    private int id; // FK tới tblUser.ID
    private Users user; // Thông tin từ tblUser

    public Customer() {
    }

    public Customer(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", user=" + user +
                '}';
    }
}

