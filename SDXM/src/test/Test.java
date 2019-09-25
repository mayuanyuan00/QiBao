package test;
import java.io.File;  
import java.io.IOException;  
import java.io.StringReader;  
import org.apache.lucene.analysis.Analyzer;  
import org.apache.lucene.analysis.TokenStream;  
import org.apache.lucene.analysis.tokenattributes.TermAttribute;  
import org.apache.lucene.document.Document;  
import org.apache.lucene.document.Field;  
import org.apache.lucene.document.Field.Index;  
import org.apache.lucene.document.Field.Store;  
import org.apache.lucene.index.CorruptIndexException;  
import org.apache.lucene.index.IndexWriter;  
import org.apache.lucene.index.IndexWriter.MaxFieldLength;  
import org.apache.lucene.queryParser.ParseException;  
import org.apache.lucene.queryParser.QueryParser;  
import org.apache.lucene.search.IndexSearcher;  
import org.apache.lucene.search.Query;  
import org.apache.lucene.search.ScoreDoc; 
import org.apache.lucene.search.TopDocs;  
import org.apache.lucene.search.highlight.Highlighter;  
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;  
import org.apache.lucene.search.highlight.QueryScorer;  
import org.apache.lucene.search.highlight.SimpleFragmenter;  
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;  
import org.apache.lucene.store.FSDirectory;  
import org.apache.lucene.store.LockObtainFailedException;  
import org.apache.lucene.util.Version;  
import org.wltea.analyzer.lucene.IKAnalyzer;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;



public class Test {
	/** 
	31.      * lucene3.0开始已经抛弃了原来的分词方式，转而使用新的分词方式<br> 
	32.      * 本方法以SmartChineseAnalyzer为例，演示如何分词以及取得分词之后的term 
	33.      * http://blog.csdn.net/yjflinchong/article/details/7906116 
	34.      * @throws Exception 
	35.      */  
	public static void analysis() throws Exception {  
		   Analyzer analyzer = new IKAnalyzer();  
		   String string = "据外媒报道，菲律宾国防部长加斯明9日称，多种新式战机、船只将于年内陆续交付军方，菲国防实力将得到大幅增强。但加斯明同时强调，此次军备采购与黄岩岛争端无关。";  
		   StringReader reader = new StringReader(string);  
		   TokenStream ts = analyzer.tokenStream("", reader);  
		   TermAttribute termAttribute = ts.getAttribute(TermAttribute.class);  
		   while (ts.incrementToken()) {  
			   System.out.println(termAttribute.term() + "  ");  
		   }  
		   	System.out.println();  
	}  
	
	/** 
	48.      * 建索引 
	49.      * 在构造IndexWriter时必须使用Directory作为参数了 
	50.      *  
	51.      * @throws CorruptIndexException 
	52.      * @throws LockObtainFailedException 
	53.      * @throws IOException 
	54.      */  
	private static void build() throws CorruptIndexException, LockObtainFailedException, IOException {  
			String path = "E:\\common\\hahaha";
		IndexWriter writer = new IndexWriter(FSDirectory.open(new File(path)), new StandardAnalyzer(Version.LUCENE_30), true, MaxFieldLength.LIMITED);  
		Document document = new Document();  
	document.add(new Field("text", "中国人民银行采取了一系列措施防止人民币升值，但是很遗憾，这些措施在今天看来其作用是微乎其微的。难道真的就没有什么别的措施防止人民币再次疯狂升值了吗？", Store.YES, Index.ANALYZED));  
	 writer.addDocument(document);  
		 writer.optimize();  
		writer.close();  
		 }  
	
	/** 
	65.      *  
	66.      * @param keyword 
	67.      * @throws CorruptIndexException 
	68.      * @throws IOException 
	69.      * @throws ParseException 
	70.      * @throws InvalidTokenOffsetsException 
	71.      */  
		private static void search(String keyword) throws CorruptIndexException, IOException, ParseException, InvalidTokenOffsetsException {  
		Analyzer analyzer = new IKAnalyzer();  
		QueryParser parser = new QueryParser(Version.LUCENE_30, "text", analyzer);  
		IndexSearcher searcher = new IndexSearcher(FSDirectory.open(new File("index")));  
		Query query = parser.parse(keyword);  
		System.out.println(query);  
		TopDocs topDocs = searcher.search(query, 10);  
		ScoreDoc[] scoreDocs = topDocs.scoreDocs;  
		System.out.println("hits:" + topDocs.totalHits);  
		for (ScoreDoc scoreDoc : scoreDocs) {  
		 Document doc = searcher.doc(scoreDoc.doc);  
		String text = doc.get("text");  
		System.out.println(highlight(text, query, analyzer));  
		}  
		}  
		/** 
		88.      * 高亮关键词 
		89.      * http://blog.csdn.net/yjflinchong/article/details/7906116 
		90.      * @param content 
		91.      *            需要高亮的内容 
		92.      * @param query 
		93.      *            搜索时使用的Query对象 
		94.      * @param analyzer 
		95.      *            分词器 
		96.      * @return 高亮之后的文本 
		97.      * @throws IOException 
		98.      * @throws InvalidTokenOffsetsException 
		99.      */  

		private static String highlight(String content, Query query, Analyzer analyzer) throws IOException, InvalidTokenOffsetsException {  
		SimpleHTMLFormatter formatter = new SimpleHTMLFormatter("<b>", "</b>");  
		 Highlighter highlighter = new Highlighter(formatter, new QueryScorer(query));  
			 highlighter.setTextFragmenter(new SimpleFragmenter(100));  
			String resultString = highlighter.getBestFragment(analyzer.tokenStream("", new StringReader(content)), content);  
			return resultString + "...";  
		}  





	public static void main(String[] args) throws Exception {
		//analysis();  
		build();  
		//search("人民币 升值");  


	}

}
