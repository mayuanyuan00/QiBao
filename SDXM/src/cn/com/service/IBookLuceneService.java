package cn.com.service;
import cn.com.domain.Book;
import cn.com.lucene.LuceneSearchResult;
public interface IBookLuceneService {
	public static final String FIELD_ID="id";
	public static final String FIELD_NAME = "bookName";
	public static final String FIELD_AUTHOR = "author";
	public static final String FIELD_FOLIO = "folio";
	public static final String FIELD_PRICE = "price";
	public static final String FIELD_CONTENT = "contentvalidity";
	// 索引存放目录
	public static final String INDEX_DIR = "/usr/local/tomcat/webapps/ROOT/";

	public static final String FIELD_IMAGEURL= "imageurl";
	/**
	 * 对所有文件进行重新索引
	 */
	public void rebuildAllIndex();
	/**
	 * 对指定上传文件对象进行索引并追加到已有的索引文件中
	 * @param news
	 */
	public void doIndexSingle(Book news);
	/**
	 * 根据关键字搜索,返回符合条件的分页数据
	 * @param keyword   关键字
	 * @param pageNo    起始页
	 * @param pageSize  每页要显示的记录数
	 * @return LuceneSearchResult对象
	 */
	public LuceneSearchResult<Book> doSeacher(String keyword, int pageNo,int pageSize);
	/**
	 * 更新文件的索引
	 * @param news
	 */
	public void updateIndex(Book news);
	/**
	 * 根据文件id删除索引
	 * @param id
	 */
	public void deleteIndex(Integer id);

}
