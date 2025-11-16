package model;

public class Table {
    private int id;
    private String description; // Mô tả bàn: "Bàn 1 - 4 người"
    private String status; // 'Trống','Đã đặt','Đang dùng'

    public Table() {
    }

    public Table(int id, String description, String status) {
        this.id = id;
        this.description = description;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Table{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}

