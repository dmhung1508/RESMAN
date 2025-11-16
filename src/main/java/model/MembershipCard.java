package model;

import java.sql.Date;

public class MembershipCard {
    private int id;
    private int customerId;
    private String cardType;
    private Date issueDate;
    private int points;
    private String status; // 'active', 'inactive'

    public MembershipCard() {
    }

    public MembershipCard(int id, int customerId, String cardType, Date issueDate, int points, String status) {
        this.id = id;
        this.customerId = customerId;
        this.cardType = cardType;
        this.issueDate = issueDate;
        this.points = points;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "MembershipCard{" +
                "id=" + id +
                ", customerId=" + customerId +
                ", cardType='" + cardType + '\'' +
                ", issueDate=" + issueDate +
                ", points=" + points +
                ", status='" + status + '\'' +
                '}';
    }
}

