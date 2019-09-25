package cn.com.domain;

public class Cart {
	
	private int id;
	private int userid;
	private int itemid;
	private int amount;
	
	
	
	
	public Cart() {
		super();
	}

	public Cart(int userid, int itemid, int amount) {
		super();
		this.userid = userid;
		this.itemid = itemid;
		this.amount = amount;
	}

	public Cart(int id, int userid, int itemid, int amount) {
		super();
		this.id = id;
		this.userid = userid;
		this.itemid = itemid;
		this.amount = amount;
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
	
	
}
