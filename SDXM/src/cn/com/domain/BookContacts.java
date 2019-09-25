package cn.com.domain;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/16
 * @Modefied By
 */
public class BookContacts implements java.io.Serializable {
    int id;
    int bookid;
    int booktypeid;

    public BookContacts() {
    }

    public BookContacts(int id, int bookid, int booktypeid) {
        this.id = id;
        this.bookid = bookid;
        this.booktypeid = booktypeid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public int getBooktypeid() {
        return booktypeid;
    }

    public void setBooktypeid(int booktypeid) {
        this.booktypeid = booktypeid;
    }
}
