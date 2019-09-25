package cn.com.utils;

import cn.com.vo.OrderInfo;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class DateToExcelUtil {
    public static String getExcel(List<OrderInfo> list, HttpServletRequest request){
        //第一步：创建一个workbook对应一个Excel文件
        HSSFWorkbook workbook=new HSSFWorkbook();
        //第二部：在workbook中创建一个sheet对应Excel中的sheet
        HSSFSheet sheet=workbook.createSheet("订单表");
        //第三部：在sheet表中添加表头第0行，老版本的poi对sheet的行列有限制
        HSSFRow row=sheet.createRow(0);
        //第四部：创建单元格，设置表头
        HSSFCell cell=row.createCell((short) 0);
        cell.setCellValue("订单号");
        cell=row.createCell((short) 1);
        cell.setCellValue("数量");
        cell=row.createCell((short) 2);
        cell.setCellValue("日期");
        cell=row.createCell((short) 3);
        cell.setCellValue("书名");
        cell=row.createCell((short) 4);
        cell.setCellValue("单价");
        cell=row.createCell((short) 5);
        cell.setCellValue("金额");
        //第五部：写入实体数据，实际应用中这些 数据从数据库得到，对象封装数据，集合包对象。对象的属性值对应表的每行的值
        for(int i=0;i<list.size();i++){
            HSSFRow row1=sheet.createRow(i+1);
            OrderInfo order=list.get(i);
            //创建单元格设值
            row1.createCell((short)0).setCellValue(order.getOrderno());
            row1.createCell((short)1).setCellValue(order.getAmount());
            row1.createCell((short)2).setCellValue(order.getDate().toString());
            row1.createCell((short)3).setCellValue(order.getName());
            row1.createCell((short)4).setCellValue(order.getPrice().toString());
            row1.createCell((short)5).setCellValue(order.getNum().toString());
        }
        String storeDirectoryRel="\\WEB-INF\\images";
        String storeDirectoryAbs="";
        //将文件保存到指定的位置
        try {
            SimpleDateFormat simpleDateFormat;
            simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
            Date date = new Date();
            String str = simpleDateFormat.format(date);
            Random random = new Random();
            int rannum = (int) (random.nextDouble() * (99999 - 10000 + 1)) + 10000;// 获取5位随机数
            storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel)+"\\"+rannum+str+".xls";
            FileOutputStream fos=new FileOutputStream(storeDirectoryAbs);
            workbook.write(fos);
            System.out.println("写入成功");
            fos.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return storeDirectoryAbs;
    }
}
