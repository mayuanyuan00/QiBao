package cn.com.vo;

import cn.com.domain.Columnlist;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * 按照层次结构返回所有栏目
 */
public class ColumnCascade implements Comparator{
    Integer id;
    String name;
    Integer parent;
    Boolean hasContent;
    Boolean isDelete;
    List<ColumnCascade> children;

    public ColumnCascade() {
    }

    public ColumnCascade(Integer id, String name, Integer parent, Boolean hasContent, List<ColumnCascade> children){
        this.id = id;
        this.name = name;
        this.parent = parent;
        this.hasContent = hasContent;
        this.children = children;
    }

    public ColumnCascade(Integer id, String name, Integer parent, Boolean hasContent){
        this.id = id;
        this.name = name;
        this.parent = parent;
        this.hasContent = hasContent;
        this.children = new ArrayList<ColumnCascade>();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<ColumnCascade> getChildren() {
        return children;
    }

    public void setChildren(List<ColumnCascade> children) {
        this.children = children;
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    public Boolean getHasContent() {
        return hasContent;
    }

    public void setHasContent(Boolean hasContent) {
        this.hasContent = hasContent;
    }

    public Boolean getDelete() {
        return isDelete;
    }

    public void setDelete(Boolean delete) {
        isDelete = delete;
    }

    @Override
    public int compare(Object o1, Object o2) {
        Columnlist c1 = (Columnlist)o1;
        Columnlist c2 = (Columnlist)o2;
        return c1.getLevel().compareTo(c2.getLevel());
    }
}
