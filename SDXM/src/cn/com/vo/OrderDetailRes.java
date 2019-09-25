package cn.com.vo;

import cn.com.domain.Book;

public class OrderDetailRes {
	private Book book;
	private int amount;
	private double unit;
	private double count;
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
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

	public OrderDetailRes() {
	}

	public OrderDetailRes(Book book, int amount, double unit, double count) {
		this.book = book;
		this.amount = amount;
		this.unit = unit;
		this.count = count;
	}
}
