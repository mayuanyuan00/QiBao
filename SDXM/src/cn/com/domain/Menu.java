package cn.com.domain;

/**
 * Created by Ting on 2018/4/18
 */
public class Menu {
    private Integer id;
    private String groupname;
    private String isDelete;
    private String groupcode;
    private String url;

    public Menu() {
    }

    public Menu(Integer id, String groupname, String isDelete, String groupcode, String url) {
        this.id = id;
        this.groupname = groupname;
        this.isDelete = isDelete;
        this.groupcode = groupcode;
        this.url = url;
    }

    public Menu(String groupname, String groupcode, String url) {
        this.groupname = groupname;
        this.groupcode = groupcode;
        this.url = url;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGroupname() {
        return groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }

    public String getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete;
    }

    public String getGroupcode() {
        return groupcode;
    }

    public void setGroupcode(String groupcode) {
        this.groupcode = groupcode;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
