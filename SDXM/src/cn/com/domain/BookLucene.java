package cn.com.domain;
// Generated 2017-9-19 16:11:32 by Hibernate Tools 3.4.0.CR1

import java.math.BigDecimal;

/**
 * Book generated by hbm2java
 */
public class BookLucene implements java.io.Serializable {

    private String id;
    //书名
    private String bookName;
    private String type;
    private BigDecimal price;
    private String imageurl;
    private String ebookurl;
    //作者
    private String author;
    private String isbn;
    private String press;
    private String publicationDate;
    private String revision;
    private String pages;
    private String wordcount;
    private String impression;
    //开本
    private String folio;
    private String sheet;
    private String contentvalidity;
    private String authorIntro;
    private String sampleChapters;
    private String catalog;
    private String editorial;
    private String isDelete;
    /**
     * 新书发布
     */
    private Boolean isNew;

    public BookLucene() {
    }

    public BookLucene(String bookName, String type, BigDecimal price, String imageurl, String ebookurl, String author, String isbn, String press, String publicationDate, String revision, String pages, String wordcount, String impression, String folio, String sheet, String contentvalidity, String authorIntro, String sampleChapters, String catalog, String editorial, String isDelete, Boolean isNew) {
        this.id = id;
        this.bookName = bookName;
        this.type = type;
        this.price = price;
        this.imageurl = imageurl;
        this.ebookurl = ebookurl;
        this.author = author;
        this.isbn = isbn;
        this.press = press;
        this.publicationDate = publicationDate;
        this.revision = revision;
        this.pages = pages;
        this.wordcount = wordcount;
        this.impression = impression;
        this.folio = folio;
        this.sheet = sheet;
        this.contentvalidity = contentvalidity;
        this.authorIntro = authorIntro;
        this.sampleChapters = sampleChapters;
        this.catalog = catalog;
        this.editorial = editorial;
        this.isDelete = isDelete;
        this.isNew = isNew;
    }

    public BookLucene(String id) {
        this.id = id;
    }


    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBookName() {
        return this.bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getPrice() {
        return this.price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImageurl() {
        return this.imageurl;
    }

    public void setImageurl(String imageurl) {
        this.imageurl = imageurl;
    }

    public String getEbookurl() {
        return ebookurl;
    }

    public void setEbookurl(String ebookurl) {
        this.ebookurl = ebookurl;
    }

    public String getAuthor() {
        return this.author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getIsbn() {
        return this.isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getPress() {
        return this.press;
    }

    public void setPress(String press) {
        this.press = press;
    }

    public String getPublicationDate() {
        return this.publicationDate;
    }

    public void setPublicationDate(String publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getRevision() {
        return this.revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    public String getPages() {
        return this.pages;
    }

    public void setPages(String pages) {
        this.pages = pages;
    }

    public String getWordcount() {
        return this.wordcount;
    }

    public void setWordcount(String wordcount) {
        this.wordcount = wordcount;
    }

    public String getImpression() {
        return this.impression;
    }

    public void setImpression(String impression) {
        this.impression = impression;
    }

    public String getFolio() {
        return this.folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getSheet() {
        return this.sheet;
    }

    public void setSheet(String sheet) {
        this.sheet = sheet;
    }

    public String getContentvalidity() {
        return this.contentvalidity;
    }

    public void setContentvalidity(String contentvalidity) {
        this.contentvalidity = contentvalidity;
    }

    public String getAuthorIntro() {
        return authorIntro;
    }

    public void setAuthorIntro(String authorIntro) {
        this.authorIntro = authorIntro;
    }

    public String getSampleChapters() {
        return sampleChapters;
    }

    public void setSampleChapters(String sampleChapters) {
        this.sampleChapters = sampleChapters;
    }

    public String getCatalog() {
        return this.catalog;
    }

    public void setCatalog(String catalog) {
        this.catalog = catalog;
    }

    public String getEditorial() {
        return this.editorial;
    }

    public void setEditorial(String editorial) {
        this.editorial = editorial;
    }

    public String getIsDelete() {
        return this.isDelete;
    }

    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete;
    }

    public Boolean getIsNew() {
        return isNew;
    }

    public void setIsNew(Boolean isNew) {
        this.isNew = isNew;
    }
}
