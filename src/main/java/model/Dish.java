package model;

import java.math.BigDecimal;

public class Dish {
    private int id;
    private String name;
    private BigDecimal price;
    private String type; // 'Món chính', 'Khai vị', 'Món canh', v.v.
    private String status; // 'Còn món','Hết món'
    private String description;
    private Integer dishComboID;

    public Dish() {
    }

    public Dish(int id, String name, BigDecimal price, String type, String status, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.type = type;
        this.status = status;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getDishComboID() {
        return dishComboID;
    }

    public void setDishComboID(Integer dishComboID) {
        this.dishComboID = dishComboID;
    }

    @Override
    public String toString() {
        return "Dish{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", type='" + type + '\'' +
                ", status='" + status + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}

