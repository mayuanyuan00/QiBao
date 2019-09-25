package cn.com.vo;

import cn.com.domain.Book;

public class CartInfo {
	private Book book ;
	private int count;
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public CartInfo(Book book, int count) {
		super();
		this.book = book;
		this.count = count;
	}
	
	
}
