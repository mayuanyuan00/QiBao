package cn.com.common;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;

import cn.com.domain.Book;

public class DataInsert {
	public static String driver = "com.mysql.jdbc.Driver";
	public static String url = "jdbc:mysql://106.14.139.44:3306/SDXM?useSSL=false&amp;useUnicode=true&amp;characterEncoding=UTF-8";// 之所以链接地址后面会添加参数，是为了防止中文乱码
	public static Connection conn;
	public static PreparedStatement ps = null;  
	public static String INSERT_STUDENT_SQL = "insert into release_book(book_name, type, price, imageurl,author,ISBN,publication_date,revision,contentvalidity,catalog,editorial,review,extention) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
	public static String INSERT_STUDENT_SQL2 = "insert into book(book_name, type, price, imageurl,author,ISBN,publication_date,revision,contentvalidity,catalog,editorial,review,extention) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
		Book book = null;  
		List<Book> list = insertData("D://Book.xls");
		for (int i = 0; i < list.size(); i++) {
            book = list.get(i);
            insert(INSERT_STUDENT_SQL, book);
            insert(INSERT_STUDENT_SQL2,book);
        }
		System.out.println("完活");
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	 /**
     * @param sql
     */
    public static void insert(String sql,Book book) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
        	Class.forName(driver);
			conn = DriverManager.getConnection(url, "mysql", "Hairun_2017");
            ps = conn.prepareStatement(sql);
            ps.setString(1, book.getBookName());
            ps.setString(2, book.getType());
            ps.setString(3, String.valueOf(book.getPrice()));
            ps.setString(4, book.getImageurl());
            ps.setString(5,book.getAuthor());
            ps.setString(6, book.getIsbn());
            ps.setString(7, book.getPublicationDate());
            ps.setString(8, book.getRevision());
            ps.setString(9,book.getContentvalidity());
            ps.setString(10, book.getCatalog());
            ps.setString(11,book.getEditorial());
            ps.setString(12, book.getReview());
            ps.setString(13,book.getExtention());
            boolean flag = ps.execute();
            if(!flag){
                System.out.println("Save data : bookName. = " +book.getBookName()+ "  succeed!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }


	// 得到单元格的字符串内容
	public static String getCellValue(Cell cell) {
		DecimalFormat df = new DecimalFormat("#");
		if (cell == null)
			return "";
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				return sdf.format(cell.getDateCellValue()).toString();
				// return
				// sdf.format(DateUtil.getJavaDate(cell.getNumericCellValue())).toString();
			}
			return df.format(cell.getNumericCellValue());
		case Cell.CELL_TYPE_STRING:
			// System.out.println(cell.getStringCellValue());
			return cell.getStringCellValue();
		case Cell.CELL_TYPE_FORMULA:
			return cell.getCellFormula();
		case Cell.CELL_TYPE_BLANK:
			return "";
		case Cell.CELL_TYPE_BOOLEAN:
			return cell.getBooleanCellValue() + "";
		case Cell.CELL_TYPE_ERROR:
			return cell.getErrorCellValue() + "";
		}
		return "";
	}

	public static List<Book> insertData(String path) {

		ExcelReader poi = new ExcelReader();
		List<List<String>> list = poi.read(path);
		Book book=null;
		List<Book> listAdd = new ArrayList<Book>();
		if (list != null) {
			for (int i = 1; i < list.size(); i++) {
				List<String> cellList = list.get(i);
				for (int j = 0; j < cellList.size(); j++) {
					book = new Book();
					book.setBookName(cellList.get(0));
					book.setType(cellList.get(1));
					book.setPrice(new BigDecimal(cellList.get(2)));
					book.setImageurl(cellList.get(3));
					book.setAuthor(cellList.get(4));
					book.setIsbn(cellList.get(5));
					book.setPress(cellList.get(6));
					book.setPublicationDate(cellList.get(7));
				}
				listAdd.add(book);
			}
		}
		return listAdd;
	}
	
	

}
