package cn.com.vo;

import java.util.Date;

public class OrderInfo {
    //订单号
    private String orderno;
    //数量
    private int amount;
    //日期
    private Date date;
    //订单状态
    private String status;
    //书名
    private String name;
    //价格
    private Object price;
    //金额
    private Object num;
    //订单id
    private int id;

    public int getId() {
        return id;
    }

    public String getOrderno() {
        return orderno;
    }

    public int getAmount() {
        return amount;
    }

    public Date getDate() {
        return date;
    }

    public String getStatus() {
        return status;
    }

    public String getName() {
        return name;
    }

    public Object getPrice() {
        return price;
    }

    public Object getNum() {
        return num;
    }

    public void setOrderno(String orderno) {
        this.orderno = orderno;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(Object price) {
        this.price = price;
    }

    public void setNum(Object num) {
        this.num = num;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setId(int id) {
        this.id = id;
    }
}
