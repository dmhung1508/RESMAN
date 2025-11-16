package model;

import java.math.BigDecimal;

public class OrderItem {
    private int orderItemID;
    private int quantity;
    private String note;
    private BigDecimal lineTotal;
    private Dish dish;

    public OrderItem() {
    }

    public OrderItem(int orderItemID, int quantity, String note) {
        this.orderItemID = orderItemID;
        this.quantity = quantity;
        this.note = note;
    }

    public int getOrderItemID() {
        return orderItemID;
    }

    public void setOrderItemID(int orderItemID) {
        this.orderItemID = orderItemID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public BigDecimal getLineTotal() {
        return lineTotal;
    }

    public void setLineTotal(BigDecimal lineTotal) {
        this.lineTotal = lineTotal;
    }

    public Dish getDish() {
        return dish;
    }

    public void setDish(Dish dish) {
        this.dish = dish;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderItemID=" + orderItemID +
                ", quantity=" + quantity +
                ", note='" + note + '\'' +
                ", lineTotal=" + lineTotal +
                ", dish=" + dish +
                '}';
    }
}

