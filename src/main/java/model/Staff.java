package model;

public class Staff {
    private int id; // FK tới tblUser.ID
    private String position; // 'manager','cashier','waiter','chef'
    private Users user; // Thông tin từ tblUser

    public Staff() {
    }

    public Staff(int id, String position) {
        this.id = id;
        this.position = position;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Staff{" +
                "id=" + id +
                ", position='" + position + '\'' +
                ", user=" + user +
                '}';
    }
}

