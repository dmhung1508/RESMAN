package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Bill {
    private int billID;
    private Timestamp billDate;
    private BigDecimal totalAmount;
    private String status;
    private int customerId;
    private int tableId;
    private int staffId;
    private String customerName;
    private String customerPhone;
    private String tableDescription;
    private List<OrderItem> orderItems;
    
    // Inner class OrderItem - Đại diện cho tblOrderedDish
    public static class OrderItem {
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

    public Bill() {
    }

    public Bill(int billID, Timestamp billDate, BigDecimal totalAmount, String status) {
        this.billID = billID;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    public int getBillID() {
        return billID;
    }

    public void setBillID(int billID) {
        this.billID = billID;
    }

    public Timestamp getBillDate() {
        return billDate;
    }

    public void setBillDate(Timestamp billDate) {
        this.billDate = billDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getTableDescription() {
        return tableDescription;
    }

    public void setTableDescription(String tableDescription) {
        this.tableDescription = tableDescription;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billID=" + billID +
                ", billDate=" + billDate +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                '}';
    }
}
