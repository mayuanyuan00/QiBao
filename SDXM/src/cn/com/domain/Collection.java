package cn.com.domain;
// Generated 2017-11-17 11:58:37 by Hibernate Tools 3.4.0.CR1

/**
 * Collection generated by hbm2java
 */
public class Collection implements java.io.Serializable {

	private Integer id;
	private int userid;
	private int itemid;

	public Collection() {
	}

	public Collection(int userid, int itemid) {
		this.userid = userid;
		this.itemid = itemid;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public int getUserid() {
		return this.userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getItemid() {
		return this.itemid;
	}

	public void setItemid(int itemid) {
		this.itemid = itemid;
	}

}