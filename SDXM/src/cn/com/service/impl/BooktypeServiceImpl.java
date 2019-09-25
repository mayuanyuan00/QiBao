package cn.com.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import cn.com.dao.IBookDao;
import cn.com.domain.Book;
import cn.com.service.IBookService;
import org.springframework.beans.factory.annotation.Autowired;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;
import org.springframework.stereotype.Service;

import cn.com.dao.IBooktypeDao;
import cn.com.domain.Booktype;
import cn.com.service.IBooktypeService;
import cn.com.vo.Pair;


@Service("booktypeService")
public class BooktypeServiceImpl implements IBooktypeService {

    @Resource(name = "booktypeDao")
    private IBooktypeDao booktypeDao;

    @Override
    public List<Booktype> getTypesByName(String name) {
        Object[] parems = new Object[1];
        String whql = "and o.isDelete != '1' and o.typeName = ?";
        parems = new Object[]{name};
        List<Booktype> list = new ArrayList<>();
        list.addAll(booktypeDao.findObjectsByConditionWithNoPage(whql, parems, null));
        return list;
    }

    @Override
    public List<Pair<Integer, Booktype>> getTypesByLikeName(String name) {
        name = "%" + name + "%";
        Object[] parems = new Object[]{name};
        String whql = "and o.isDelete != '1' and o.typeName like ?";
        List<Booktype> list = new ArrayList<>();
        list.addAll(booktypeDao.findObjectsByConditionWithNoPage(whql, parems, null));
        List<Pair<Integer, Booktype>> booktypes = new ArrayList<Pair<Integer, Booktype>>();
        for (Booktype temp : list) {
            booktypes.add(new Pair<>(0, temp));
        }
        return booktypes;
    }

    @Override
    public List<Booktype> getAllTypes(Integer parent) {
        String whql = "and o.isDelete != '1' ";
        if (parent == null) parent = 0;
        whql = whql + "and o.parentid = " + parent;
        return this.booktypeDao.findObjectsByConditionWithNoPage(whql);
    }

    @Override
    public Map<Integer, String> getAllTypesOfMap(Integer parent) {
        List<Booktype> booktypes = this.getAllTypes(parent);
        Map<Integer, String> booktypeMap = new HashMap<>();
        if (booktypes != null) {
            for (Booktype booktype : booktypes) {
                booktypeMap.put(booktype.getId(), booktype.getTypeName());
            }
        }
        return booktypeMap;
    }

    @Override
    public List<Map<String, Object>> getParentMappedTypes() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Booktype> booktypes = getAllTypes(null);
        for (Booktype booktype : booktypes) {
            Map<String, Object> m = new HashMap<>();
            result.add(m);
            m.put("id", booktype.getId());
            m.put("name", booktype.getTypeName());
            m.put("sub", this.getAllTypes(booktype.getId()));
        }
        return result;
    }


    @Override
    public void saveBookType(Booktype booktype) {
        booktype.setIsDelete("0");//TODO??? 如果已经删除的再保存怎么办
        booktype.setState(0);
        this.booktypeDao.saveEntry(booktype);
    }

    @Override
    public List<Booktype> selectAllBookType() {
        List<Booktype> booktypes = new ArrayList<>();
        booktypes = this.booktypeDao.findObjectsByConditionWithNoPage("and is_delete != '1'", null, null);
        if (booktypes == null) {
            return new ArrayList<>();
        }
        return booktypes;
    }

    @Override
    public List<Pair<Integer, Booktype>> selectAllBookTypeAsTree() {
        List<Booktype> booktypes = this.selectAllBookType();
        List<Pair<Integer, Booktype>> treeBookType = new ArrayList<>();
        if (booktypes != null) {
            treeBookType = sortTree(booktypes, 0, 1);
        }
        return treeBookType;
    }

    @Override
    public List<Booktype> getAllSuperType(int typeid) {
        //TODO
        throw new NotImplementedException();
    }

    @Override
    public Booktype selectBookTypeById(Integer id) {
        Integer[] parems = new Integer[1];
        parems[0] = id;
        List<Booktype> booktype = this.booktypeDao.findObjectsByConditionWithNoPage("and is_delete != '1' and id = ?", parems, null);
        if (booktype.size() == 0) {
            return null;
        } else if (booktype.size() == 1) {
            return booktype.get(0);
        }
        return null;
    }

    @Override
    public int deleteBookType(Integer id) {
        return this.booktypeDao.logicDelete(id);
    }

    @Override
    public void updateBookType(Booktype booktype) {
        this.booktypeDao.updateEntry(booktype);
    }

    @Override
    public List<Integer> getParentList(Integer id) {
        List<Booktype> booktypes = this.selectAllBookType();
        List<Integer> parent = getParentIdList(booktypes, id, new ArrayList<Integer>());
        Collections.reverse(parent);
        return parent;
    }

    /**
     * 获取父亲连
     *
     * @param booktypes 全部
     * @param id        需要查询的id
     * @param parent
     * @return
     */
    private List<Integer> getParentIdList(List<Booktype> booktypes, Integer id, List<Integer> parent) {
        parent.add(id);
        for (Booktype b : booktypes) {
            if (b.getId().equals(id)) {
                parent = getParentIdList(booktypes, b.getParentid(), parent);
                break;
            }
        }
        return parent;
    }


    /**
     * 将传来的列表以树的形式重新排序返回
     *
     * @param list  需要排序的列表
     * @param id    树（子树）的根节点id
     * @param level 当前的层级 最开始为1级
     * @return 排序好的列表
     */
    private List<Pair<Integer, Booktype>> sortTree(List<Booktype> list, Integer id, Integer level) {
        List<Pair<Integer, Booktype>> resultList = new ArrayList<>();
        if (list == null || list.size() == 0) {
            return resultList;
        }
        for (Booktype temp : list) {
            if (null == temp.getParentid()) {
                continue;
            }
            if (temp.getParentid().equals(id)) {
//                String ap = "";
//                for (int i = 1; i < level; i++) {
//                    ap += "————|";
//                }
//                temp.setTypeName(ap + temp.getTypeName());
                resultList.add(new Pair<>(level, temp));
                resultList.addAll(sortTree(list, temp.getId(), level + 1));
            }
        }
        return resultList;
    }
}
