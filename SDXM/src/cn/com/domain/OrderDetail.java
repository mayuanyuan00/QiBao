package cn.com.domain;

public class OrderDetail {
	private int id;
	private int orderid;
	private int itemid;
	private int amount;
	private String expno;
	private String expid;
	private double unit;
	private double count;
	private String orderno;
	
	
	public OrderDetail() {
		super();
	}
	public OrderDetail(int orderid, int itemid, int amount, double unit, double count) {
		super();
		this.orderid = orderid;
		this.itemid = itemid;
		this.amount = amount;
		this.unit = unit;
		this.count = count;
		
	}
	
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public int getItemid() {
		return itemid;
	}
	public void setItemid(int itemid) {
		this.itemid = itemid;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getExpno() {
		return expno;
	}
	public void setExpno(String expno) {
		this.expno = expno;
	}
	public String getExpid() {
		return expid;
	}
	public void setExpid(String expid) {
		this.expid = expid;
	}
	public double getUnit() {
		return unit;
	}
	public void setUnit(double unit) {
		this.unit = unit;
	}
	public double getCount() {
		return count;
	}
	public void setCount(double count) {
		this.count = count;
	}
}
