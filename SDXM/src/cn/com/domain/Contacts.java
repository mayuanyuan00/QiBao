package cn.com.domain;
// Generated 2017-11-7 17:13:49 by Hibernate Tools 3.4.0.CR1

/**
 * Contacts generated by hbm2java
 */
public class Contacts implements java.io.Serializable {

	private Integer id;
	private String linkman;
	private String phone;
	private String mail;
	private String message;

	public Contacts() {
	}

	public Contacts(String linkman, String phone, String mail, String message) {
		this.linkman = linkman;
		this.phone = phone;
		this.mail = mail;
		this.message = message;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLinkman() {
		return this.linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMail() {
		return this.mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
