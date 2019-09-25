package cn.com.common;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.springframework.stereotype.Component;

import cn.com.domain.Book;

/**
 * excel导入图书
 * @author 常东旭
 *
 */
@Component
public class BookImportService {


	    public List<Book> readXls(InputStream is) throws IOException {
	        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
	        Book book = null;
	        List<Book> list = new ArrayList<Book>();
	        // 循环工作表Sheet
	        for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
	            HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
	            if (hssfSheet == null) {
	                continue;
	            }
	            // 循环行Row
	            for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
	                HSSFRow hssfRow = hssfSheet.getRow(rowNum);
	                if (hssfRow != null) {
	                    book = new Book();
	                    HSSFCell bookName = hssfRow.getCell(0);
	                    HSSFCell type = hssfRow.getCell(1);
	                    HSSFCell price = hssfRow.getCell(2);
	                    HSSFCell imageurl = hssfRow.getCell(3);
	                    HSSFCell author = hssfRow.getCell(4);
	                    HSSFCell isbn = hssfRow.getCell(5);
	                    HSSFCell press = hssfRow.getCell(6);
	                    HSSFCell publicationDate = hssfRow.getCell(7);
	                    HSSFCell revision = hssfRow.getCell(8);
	                    HSSFCell pages = hssfRow.getCell(9);
	                    HSSFCell wordcount = hssfRow.getCell(10);
	                    HSSFCell impression = hssfRow.getCell(11);
	                    HSSFCell folio = hssfRow.getCell(12);
	                    HSSFCell sheet = hssfRow.getCell(13);
	                    HSSFCell contentvalidity = hssfRow.getCell(14);
	                    HSSFCell catalog = hssfRow.getCell(15);
	                    HSSFCell editorial = hssfRow.getCell(16);
	                    HSSFCell isDelete = hssfRow.getCell(17);
	                    
	                    book.setBookName((String) getValue(bookName));
	                    book.setType((String) getValue(type));
	                    book.setPrice((BigDecimal) getValue(price));
	                    book.setImageurl((String) getValue(imageurl));
	                    book.setAuthor((String) getValue(author));
	                    book.setIsbn((String) getValue(isbn));
	                    book.setPress((String) getValue(press));
	                    book.setPublicationDate((String) getValue(publicationDate));
	                    book.setRevision((String) getValue(revision));
	                    book.setPages((String) getValue(pages));
	                    book.setWordcount((String) getValue(wordcount));
	                    book.setImpression((String) getValue(impression));
	                    book.setFolio((String) getValue(folio));
	                    book.setSheet((String) getValue(sheet));
	                    book.setContentvalidity((String) getValue(contentvalidity));
	                    book.setCatalog((String) getValue(catalog));
	                    book.setEditorial((String) getValue(editorial));
	                    book.setIsDelete((String) getValue(isDelete));
	                    
	                    list.add(book);
	                }
	            }
	        }
	        return list;
	    }
	    
		private Object getValue(HSSFCell hssfCell) {
	            if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
	                // 返回布尔类型的值
	                return String.valueOf(hssfCell.getBooleanCellValue());
	            } else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
	                // 返回数值类型的值
	            	 if (HSSFDateUtil.isCellDateFormatted(hssfCell)) {// 处理日期格式、时间格式  
//	                     SimpleDateFormat sdf = null;  
//	                     if (hssfCell.getCellStyle().getDataFormat() == HSSFDataFormat  
//	                             .getBuiltinFormat("h:mm")) {  
//	                         sdf = new SimpleDateFormat("HH:mm");  
//	                     } else {// 日期  
//	                         sdf = new SimpleDateFormat("yyyy-MM-dd");  
//	                     }  
	                     Date date = hssfCell.getDateCellValue();  
	                     return date;  
	                 } else if (hssfCell.getCellStyle().getDataFormat() == 58) {  
	                     // 处理自定义日期格式：m月d日(通过判断单元格的格式id解决，id的值是58)  
//	                     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
	                     double value = hssfCell.getNumericCellValue();  
	                     Date date = org.apache.poi.ss.usermodel.DateUtil  
	                             .getJavaDate(value);  
	                    return date;  
	                 } else {  
	                     double value = hssfCell.getNumericCellValue();  
	                     CellStyle style = hssfCell.getCellStyle();  
//	                     DecimalFormat format = new DecimalFormat();  
//	                     String temp = style.getDataFormatString();  
//	                     // 单元格设置成常规  
//	                     if (temp.equals("General")) {  
//	                         format.applyPattern("#");  
//	                     }  
//	                     result = format.format(value);  
	                     return value;
	                 }  
	            }  else {
	                // 返回字符串类型的值
	                return String.valueOf(hssfCell.getStringCellValue());
	            }
	        }
}
