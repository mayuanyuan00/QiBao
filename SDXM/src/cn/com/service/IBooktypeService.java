package cn.com.service;

import cn.com.domain.Booktype;
import cn.com.vo.Pair;

import java.util.List;
import java.util.Map;

public interface IBooktypeService {


    /**
     * 根据名字返回分类
     *
     * @return 分类列表
     */
    List<Booktype> getTypesByName(String name);

    /**
     * 根据名字相似返回
     *
     * @return 分类列表
     */
    List<Pair<Integer, Booktype>> getTypesByLikeName(String name);

    /**
     * 返回所有可以访问的Type
     *
     * @param parent 父元素ID，若为null则为顶层类型
     * @return
     */
    List<Booktype> getAllTypes(Integer parent);

    /**
     * 返回所有的可以访问的书籍类型的Map，其中key为type的ID，value为type的Name
     *
     * @param parent 父元素ID，若为null则为顶层类型
     * @return
     */
    Map<Integer, String> getAllTypesOfMap(Integer parent);

    /**
     * 获取父类型映射到子类型的一个Map<br/>
     * 此方法用于导航
     * <p>
     * 其中Key:<br/>
     * = id    ：父类型的ID<br/>
     * = name  ：父类型的名字<br/>
     * = sub   ：子类型数组，类型为List&lt;Booktype&gt {@link cn.com.domain.Booktype};
     *
     * @return
     */
    List<Map<String, Object>> getParentMappedTypes();

    /**
     * 新增图书分类
     *
     * @param booktype 新增图书分类信息 isDelete 应为一位字符串 “1”或“0” 默认为“0”；
     *                 state 默认为 0
     *                 parentid   默认为0
     */
    void saveBookType(Booktype booktype);

    /**
     * 查询所有未被标记为删除的图书分类
     *
     * @return 如果没有结果 则返回空列表（不返回null）
     */
    List<Booktype> selectAllBookType();

    /**
     * 查询所有未被标记为删除的图书分类
     *
     * @return 如果没有结果 则返回空列表（不返回null） 返回结果将按照树的形式排序
     */
    List<Pair<Integer, Booktype>> selectAllBookTypeAsTree();

    /**
     * 获取指定子菜单的所有父菜单，包括当前菜单
     *
     * @param typeid
     * @return
     */
    List<Booktype> getAllSuperType(int typeid);

    /**
     * 根据id查询图书类型
     *
     * @param id 图书类型id
     * @return 若无结果 或者查询出多个结果 则返回 null
     */
    Booktype selectBookTypeById(Integer id);

    /**
     * 根据id删除相应图书分类（isDelete属性设为“1”） 并将相应子节点等的图书分类做相同操作
     *
     * @param id 需要删除的图书分类id
     */
    int deleteBookType(Integer id);

    /**
     * 修改相应的图书分类
     *
     * @param booktype 其id为要修改的图书分类的id，其他属性则为需要修改的属性  id 不允许为null
     */
    void updateBookType(Booktype booktype);


    /**
     * 获取图书分类父亲id连
     */
    List<Integer> getParentList(Integer id);
}
