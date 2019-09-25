package cn.com.vo;

import java.util.List;

public class OrderRes {
	private int id;
	private List<OrderDetailRes> detail;
	private double count;
	private String status;
	private String create_date;
	private String orderno;

	private String owner;
	private String address;
	
	public int getId() {
		return id;
	}
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public void setId(int id) {
		this.id = id;
	}
	public List<OrderDetailRes> getDetail() {
		return detail;
	}
	public void setDetail(List<OrderDetailRes> detail) {
		this.detail = detail;
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
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
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
}
