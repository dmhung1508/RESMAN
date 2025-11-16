package model;

import java.sql.Date;

public class Payment {
    private int paymentID;
    private double amount;
    private String method;
    private Date date;

    public Payment() {
    }

    public Payment(int paymentID, double amount, String method, Date date) {
        this.paymentID = paymentID;
        this.amount = amount;
        this.method = method;
        this.date = date;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "paymentID=" + paymentID +
                ", amount=" + amount +
                ", method='" + method + '\'' +
                ", date=" + date +
                '}';
    }
}

