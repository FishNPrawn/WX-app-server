package com.example.fishnprawn.utils;

import com.example.fishnprawn.category.Category;
import java.lang.*;

import com.example.fishnprawn.comment.Comment;
import com.example.fishnprawn.good.Good;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Slf4j
public class ExcelImport {

    // category以excel表格的形式导入
    public static List<Category> excelToCategoryList(InputStream inputStream){
        List<Category> list = new ArrayList<>();

        Workbook workbook = null;
        try {
            workbook = WorkbookFactory.create(inputStream);
            inputStream.close();

            //工作表对象
            Sheet sheet = workbook.getSheetAt(0);

            //总行数
            int rowLength = sheet.getLastRowNum();
            System.out.println("总行数有多少行" + rowLength);

            //工作表的列
            Row row = sheet.getRow(0);

            //总列数
            int colLength = row.getLastCellNum();
            System.out.println("总列数有多少列" + colLength);

            //得到指定的单元格
            Cell cell = row.getCell(0);
            for(int i = 1; i <= rowLength; i++){
                Category categoryInfo = new Category();
                row = sheet.getRow(i);

                for(int j = 0; j < colLength; j++){
                    cell = row.getCell(j);
                    if(cell != null){
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        String data = cell.getStringCellValue();
                        data = data.trim();
                        //column: 0. category
                        if(j == 0){
                            categoryInfo.setCatname(data);
                        }else if(j == 1){
                            categoryInfo.setCat_image(data);
                        }
                    }
                }
                list.add(categoryInfo);
            }
        } catch (Exception e) {
            log.error("excel导入错误={}", e);
        }
        System.out.println("list:" + list);
        return list;
    }


    //menulist以excel的形式导入
    public static List<Good> excelToMenulistList(InputStream inputStream){
        List<Good> list = new ArrayList<>();

        Workbook workbook = null;
        try {
            workbook = WorkbookFactory.create(inputStream);
            inputStream.close();

            //工作表对象
            Sheet sheet = workbook.getSheetAt(0);

            //总行数
            int rowLength = sheet.getLastRowNum();
            System.out.println("总行数有多少行" + rowLength);

            //工作表的列
            Row row = sheet.getRow(0);

            //总列数
            int colLength = row.getLastCellNum();
            System.out.println("总列数有多少列" + colLength);

            //得到指定的单元格
            Cell cell = row.getCell(0);
            for(int i = 1; i <= rowLength; i++){
                Good goodInfo = new Good();
                row = sheet.getRow(i);

                for(int j = 0; j < colLength; j++){
                    cell = row.getCell(j);
                    if(cell != null){
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        String data = cell.getStringCellValue();
                        data = data.trim();
                        //column: 0. good_name-商品名字
                        if(j == 0){
                            goodInfo.setGood_name(data);
                        }
                        //column: 1. cat_name-商品分类
                        else if(j == 1){
                            goodInfo.setCat_name(data);
                        }
                        //column: 2. good_origin_price-原价格
                        else if(j == 2){
                            goodInfo.setGood_origin_price(Double.parseDouble(data));
                        }
                        //column: 3. good_price-优惠价格
                        else if(j == 3){
                            goodInfo.setGood_price(Double.parseDouble(data));
                        }
                        //column: 4. good_weight-库存
                        else if(j == 4){
                            goodInfo.setGood_stock(Integer.parseInt(data));
                        }
                        //column: 5. good_stock-重量
                        else if(j == 5){
                            goodInfo.setGood_weight(Double.parseDouble(data));
                        }
                        //column: 6. good_size-规格
                        else if(j == 6){
                            goodInfo.setGood_size(data);
                        }
                        //column: 7. good_supplier-供应商
                        else if(j == 7){
                            goodInfo.setGood_supplier(data);
                        }
                        //column: 8. good_production-产地
                        else if(j == 8){
                            goodInfo.setGood_production(data);
                        }
                        //column: 9. good_expiration-销量
                        else if(j == 9){
                            goodInfo.setGood_expiration(data);
                        }
                        //column: 10. good_optimal_period-品味最佳期
                        else if(j == 10){
                            goodInfo.setGood_optimal_period(data);
                        }
                        //column: 11. good_publish_date-发布日期
                        else if(j == 11){

                            goodInfo.setGood_publish_date(new Date(1996-05-26));
                        }
                        //column: 12. good_description-商品详情
                        else if(j == 12){
                            goodInfo.setGood_description(data);
                        }
                        //column: 13. good_status-status
                        else if(j == 13){
                            goodInfo.setGood_status(Integer.parseInt(data));
                        }
                        //column: 14. good_image-图片1
                        else if(j == 14){
                            goodInfo.setGood_image(data);
                        }
                        //column: 15. good_image1-图片2
                        else if(j == 15){
                            goodInfo.setGood_image_1(data);
                        }
                        //column: 16. good_image_description-长图片
                        else if(j == 16){
                            goodInfo.setGood_image_description(data);
                        }
                        //column: 16. good_cat_image-分类图片
                        else if(j == 17){
                            goodInfo.setGood_cat_image(data);
                        }
                    }
                }
                list.add(goodInfo);
            }
        } catch (Exception e) {
            log.error("excel导入错误={}", e);
        }
        System.out.println("list:" + list);
        return list;
    }


    // comment以excel表格的形式导入
    public static List<Comment> excelToCommentList(InputStream inputStream){
        List<Comment> list = new ArrayList<>();

        Workbook workbook = null;
        try {
            workbook = WorkbookFactory.create(inputStream);
            inputStream.close();

            //工作表对象
            Sheet sheet = workbook.getSheetAt(0);

            //总行数
            int rowLength = sheet.getLastRowNum();
            System.out.println("总行数有多少行" + rowLength);

            //工作表的列
            Row row = sheet.getRow(0);

            //总列数
            int colLength = row.getLastCellNum();
            System.out.println("总列数有多少列" + colLength);

            //得到指定的单元格
            Cell cell = row.getCell(0);
            for(int i = 1; i <= rowLength; i++){
                Comment commentInfo = new Comment();
                row = sheet.getRow(i);

                for(int j = 0; j < colLength; j++){
                    cell = row.getCell(j);
                    if(cell != null){
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        String data = cell.getStringCellValue();
                        data = data.trim();
                        //column: 0. username
                        if(j == 0){
                            commentInfo.setUsername(data);
                        }
                        // 1. good_id
                        else if(j == 1){
                            commentInfo.setGoodId(Integer.parseInt(data));
                        }
                        // 2. 商品名
                        else if(j == 2){
                            commentInfo.setName(data);
                        }
                        // 3. 评论内容
                        else if(j == 3){
                            commentInfo.setContent(data);
                        }
                        // 4. 头像
                        else if(j == 4){
                            commentInfo.setImage(data);
                        }
                        // 5. 时间
                        else if(j == 5){
                            commentInfo.setComment_create_time(data);
                        }
                    }
                }
                list.add(commentInfo);
            }
        } catch (Exception e) {
            log.error("excel导入错误={}", e);
        }
        System.out.println("list:" + list);
        return list;
    }

}
