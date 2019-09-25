package cn.com.vo;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/12
 * @Modefied By
 */
public class BookVO {

    private Integer id;
    private String bookType;
    private String bookName;
    private String author;
    private String publicationDate;
    private String auditing;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBookType() {
        return bookType;
    }

    public void setBookType(String bookType) {
        this.bookType = bookType;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(String publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getAuditing() {
        return auditing;
    }

    public void setAuditing(String auditing) {
        this.auditing = auditing;
    }
}
