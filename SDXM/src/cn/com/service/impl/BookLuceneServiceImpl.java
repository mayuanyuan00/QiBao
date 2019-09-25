package cn.com.service.impl;


import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.sun.security.sasl.gsskerb.FactoryImpl;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriter.MaxFieldLength;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleFragmenter;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.apache.lucene.util.Version;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.dao.IBookDao;
import cn.com.domain.Book;
import cn.com.lucene.LuceneSearchResult;
import cn.com.service.IBookLuceneService;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/16
 * @Modefied By
 */
@Service("bookLuceneService")
public class BookLuceneServiceImpl implements IBookLuceneService {

	 @Resource(name = "bookDao")
	  private IBookDao bookDao;
	/** 获取语法解析器 */
	public Analyzer getAnalyzer() {
		return new StandardAnalyzer(Version.LUCENE_30);
		
	}
	/** 打开索引的存放目录 */
	public Directory openDirectory() {
		try {
			System.out.println(new File(INDEX_DIR)	+ "-------打开索引--------------");
			return FSDirectory.open(new File(INDEX_DIR));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/** 对文件的指定属性映射成域,返回文件文档对象 */  
	public Document createForumuploadDocument(Book book) {
		Document doc = new Document(); // 创建一个文档对象
		//id 域
		Field field = new Field(FIELD_ID,String.valueOf(book.getId()),Field.Store.YES, Field.Index.NOT_ANALYZED);
		doc.add(field);
		// 书名
		Field field1 = new Field(FIELD_NAME, String.valueOf(book.getBookName()),Field.Store.YES, Field.Index.ANALYZED);
		doc.add(field1);
		// 作者
		Field field2 = new Field(FIELD_AUTHOR, String.valueOf(book.getAuthor()), Field.Store.YES, Field.Index.ANALYZED);
		doc.add(field2);
		// 开本
		Field field3 = new Field(FIELD_FOLIO, String.valueOf(book.getFolio()), Field.Store.YES, Field.Index.ANALYZED);
		doc.add(field3);
		// 价格
		Field field4 = new Field(FIELD_PRICE, String.valueOf(book.getPrice()), Field.Store.YES, Field.Index.ANALYZED);
		doc.add(field4);
		//内容
		Field field5 = new Field(FIELD_CONTENT, String.valueOf(book.getContentvalidity()), Field.Store.YES, Field.Index.ANALYZED);
		doc.add(field5);
		//图片
		Field field6 = new Field(FIELD_IMAGEURL, String.valueOf(book.getImageurl()), Field.Store.YES, Field.Index.ANALYZED);
		doc.add(field6);
		return doc;
	}
	
	public void deleteIndex(Integer id) {
		IndexReader ir = null;  
		try {  
			ir = IndexReader.open(this.openDirectory(), false);  //打开指定目录下索引文件的索引读取器  
			ir.deleteDocuments(new Term(FIELD_ID,String.valueOf(id)));  //删除符合条件的Document  
		} catch (IOException e) {  
			e.printStackTrace();  
		}finally{  
			if(ir != null){  
				try {  
					ir.close();  
				} catch (IOException e) {  
					e.printStackTrace();  
				}  
			}  
		}  
	}
	/** 
	* 建索引 
	* 在构造IndexWriter时必须使用Directory作为参数了 
	*  
	* @throws CorruptIndexException 
	* @throws LockObtainFailedException 
	* @throws IOException 
	*/  
	public void doIndexSingle(Book book) {
		//创建索引写入器  
		//IndexWriter indexWriter = null;
		try {
			//IndexWriter indexWriter = new IndexWriter(openDirectory(), getAnalyzer(),false, IndexWriter.MaxFieldLength.UNLIMITED);
			IndexWriter writer = new IndexWriter(FSDirectory.open(new File(INDEX_DIR)), getAnalyzer(),false, MaxFieldLength.LIMITED);  
			Document doc = this.createForumuploadDocument(book);
			writer.addDocument(doc);
			writer.optimize(); // 对索引进行优化
			writer.close();  
		} catch (CorruptIndexException e) {
			e.printStackTrace();
		} catch (LockObtainFailedException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		
		}
	}


	public LuceneSearchResult<Book> doSeacher(String keyword, int pageNo,int pageSize) {
		LuceneSearchResult<Book> lsr = new LuceneSearchResult<Book>();
		lsr.setPageNo(pageNo);
		lsr.setPageSize(pageSize);
		lsr.setKeyword(keyword);
		IndexSearcher searcher = null;
		try {
			
			rebuildAllIndex();
			// 创建一个索引搜索器
			searcher = new IndexSearcher(this.openDirectory(), true);
			// 用多域查询解析器来创建一个查询器,
			/*Query query = MultiFieldQueryParser.parse(Version.LUCENE_30,keyword, new String[] { FIELD_NAME, FIELD_AUTHOR, FIELD_CONTENT},
					new BooleanClause.Occur[] {BooleanClause.Occur.SHOULD,BooleanClause.Occur.SHOULD,BooleanClause.Occur.SHOULD }, this.getAnalyzer());*/
			Query query = MultiFieldQueryParser.parse(Version.LUCENE_30,keyword, new String[] { FIELD_NAME, FIELD_AUTHOR},
					new BooleanClause.Occur[] {BooleanClause.Occur.SHOULD,BooleanClause.Occur.SHOULD}, this.getAnalyzer());
			long begin = System.currentTimeMillis();
			// 查询结集信息类
			TopDocs ts = searcher.search(query, null, 100000);
			// 获取命中的数量
			lsr.setRecordCount(ts.totalHits);
			// 用这个进行高亮显示，默认是<b>..</b>
			SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter("<span style='color:red;display:inline;'>", "</span>");
			// 构造高亮:指定高亮的格式,指定查询评分
			Highlighter highlighter = new Highlighter(simpleHTMLFormatter,new QueryScorer(query));highlighter.setTextFragmenter(new SimpleFragmenter(Integer.MAX_VALUE));
			// 获取匹配到的结果集
			ScoreDoc[] hits = ts.scoreDocs;
			List<Book> ais = new ArrayList<Book>();
			int pageCount = (lsr.getRecordCount() + pageSize - 1) / pageSize; // 总页数
			int start = 0; // 要开始返回的文档编号
			int end = 0; // 要结束返回的文档编号
			if (pageCount > 0) {
				start = (pageNo - 1) * pageSize;
				end = start + pageSize;
				if (pageNo == pageCount) { // 处理最后一页的结束文档的编号
					end = start + (lsr.getRecordCount() % pageSize);
				}
			}
			if (start < end) {
				lsr.setStratNo(start + 1);
				lsr.setEndNo(end);
			}
			for (int i = start; i < end; i++) { // 循环获取分页数据
				// 通过内部编号从搜索器中得到对应的文档
				Document doc = searcher.doc(hits[i].doc);
				Book book = new Book();
				book.setId(Integer.parseInt(doc.getField(FIELD_ID).stringValue()));
				book.setBookName(doc.getField(FIELD_NAME).stringValue());
				book.setAuthor(doc.getField(FIELD_AUTHOR).stringValue()); 
				book.setFolio(doc.getField(FIELD_FOLIO).stringValue());
				book.setImageurl(doc.getField(FIELD_IMAGEURL).stringValue());
				book.setPrice(new BigDecimal(doc.getField(FIELD_PRICE).stringValue()));

				//book.setContentvalidity(doc.getField(FIELD_CONTENT).stringValue());
				// 处理图书名称的高亮显示问题
				String title = doc.getField(FIELD_NAME).stringValue();
				String title2 = highlighter.getBestFragment(this.getAnalyzer(),FIELD_NAME, title);
				if (title2 == null) {
					book.setBookName(title);
				} else {
					book.setBookName(title2);
				}
				// 作者高亮显示
				String contents1 = doc.getField(FIELD_AUTHOR).stringValue();
				String contents2 = highlighter.getBestFragment(this.getAnalyzer(), FIELD_AUTHOR, contents1);
				if (contents2 == null) {
					book.setAuthor(contents1);
				} else {
					if (contents2.length() > 512) {
						book.setAuthor(contents2.substring(0, 512) + "...");
					} else {
						book.setAuthor(contents2);
					}
				}
				ais.add(book); // 把符合条件的数据添加到List
			}
			lsr.setTime((System.currentTimeMillis() - begin) / 1000.0); // 计算搜索耗时秒数
			lsr.setResults(ais); // 把查询到的数据添加到LuceneSearchResult
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (InvalidTokenOffsetsException e) {
			e.printStackTrace();
		} finally {
			if (searcher != null) {
				try {
					searcher.close(); // 关闭搜索器
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lsr;
	}
	/**
     * 创建索引
     * 并把数据库中的数据写进索引
     * @throws Exception
     */

	@Override
	@Transactional
	public void rebuildAllIndex() {
		File file = new File(INDEX_DIR);
		if (file.exists()) {
			for (File subFile : file.listFiles()) {
				subFile.delete();
			}
		} else {
			file.mkdirs();
		}
		List<Book> data = this.bookDao.findObjectsByConditionWithNoPage("and is_delete != '1' and auditing = '3'", null, null);
		IndexWriter indexWriter = null;
		try {
			indexWriter = new IndexWriter(FSDirectory.open(new File(INDEX_DIR)), getAnalyzer(),true, MaxFieldLength.LIMITED);  
			// 设置打开使用复合文件
			// indexWriter.setUseCompoundFile(true);
			int size = data == null ? 0 : data.size();
			for (int i = 0; i < size; i++) {
				Book news = data.get(i);
				Document doc = createForumuploadDocument(news);
				indexWriter.addDocument(doc);
				if (i % 20 == 0) {
					indexWriter.commit();
				}
			}
			indexWriter.optimize(); // 对索引进行优化
		} catch (CorruptIndexException e) {
			e.printStackTrace();
		} catch (LockObtainFailedException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (indexWriter != null) {
					indexWriter.close();// 关闭IndexWriter,把内存中的数据写到文件
				}
			} catch (CorruptIndexException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	public void updateIndex(Book news) {
		this.deleteIndex(news.getId());  
		this.doIndexSingle(news);  
	}
}
