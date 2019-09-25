package cn.com.domain;

import java.util.Date;

import cn.com.utils.DateUtils;

public class Order {
	private int id;
	private int userid;
	private double count;
	private String status;
	private int grade;
	private String comment;
	private String orderno;
	private String address;
	private String owner;
	private Date create_date;
	private String expno;
	private String express;
	
	
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public Order() {
		super();
	}

	public Order(int userid, double count, String status, int grade, String comment) {
		super();
		this.userid = userid;
		this.count = count;
		this.status = status;
		this.grade = grade;
		this.comment = comment;
		this.create_date = new Date();
	}
	
	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public double getCount() {
		return count;
	}
	public void setCount(double count) {
		this.count = count;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getExpno() {
		return expno;
	}

	public void setExpno(String expno) {
		this.expno = expno;
	}

	public String getExpress() {
		return express;
	}

	public void setExpress(String express) {
		this.express = express;
	}
}
