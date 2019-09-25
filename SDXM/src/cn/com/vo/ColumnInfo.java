package cn.com.vo;

/**
 * Created by tinanoro on 2017/9/25.
 */
public class ColumnInfo {
    private Integer firstColumnId;
    private Integer secondColumnId;
    private String secondColumnName;
    private Boolean hasContent;
    private Boolean parent;

    public Boolean getParent() {
        return parent;
    }

    public void setParent(Boolean parent) {
        this.parent = parent;
    }

    public Integer getFirstColumnId() {
        return firstColumnId;
    }

    public void setFirstColumnId(Integer firstColumnId) {
        this.firstColumnId = firstColumnId;
    }

    public Integer getSecondColumnId() {
        return secondColumnId;
    }

    public void setSecondColumnId(Integer secondColumnId) {
        this.secondColumnId = secondColumnId;
    }

    public String getSecondColumnName() {
        return secondColumnName;
    }

    public void setSecondColumnName(String secondColumnName) {
        this.secondColumnName = secondColumnName;
    }

    public Boolean getHasContent() {
        return hasContent;
    }

    public void setHasContent(Boolean hasContent) {
        this.hasContent = hasContent;
    }
}
