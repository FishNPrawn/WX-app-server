package com.example.fishnprawn.utils;

import com.example.fishnprawn.category.Category;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Slf4j
public class ExcelImport {

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
                        //column: 0. category
                        if(j == 0){
                            categoryInfo.setCat_name(data);
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
}
