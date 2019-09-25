package cn.com.vo;

import cn.com.domain.Book;

public class OderInfo {
	
	private Book book ;
	/**
	 * 数量
	 */
	private int count;
	
	
	
	public OderInfo(Book book, int count) {
		super();
		this.book = book;
		this.count = count;
	}
	
	
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
	
	
}
