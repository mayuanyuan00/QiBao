package cn.com.vo;

/**
 * Created by Ting on 2018/4/19
 */
public class AuthorityVO {

    private int groupname;
    private String groupcode;
    private String menuname;
    private String url;

    public AuthorityVO(int groupname, String groupcode, String menuname, String url) {
        this.groupname = groupname;
        this.groupcode = groupcode;
        this.menuname = menuname;
        this.url = url;
    }

    public AuthorityVO() {
    }

    public int getGroupname() {
        return groupname;
    }

    public void setGroupname(int groupname) {
        this.groupname = groupname;
    }

    public String getGroupcode() {
        return groupcode;
    }

    public void setGroupcode(String groupcode) {
        this.groupcode = groupcode;
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
