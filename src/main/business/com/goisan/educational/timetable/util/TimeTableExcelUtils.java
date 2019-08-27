package com.goisan.educational.timetable.util;

import org.apache.poi.ss.usermodel.ShapeTypes;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFSimpleShape;

/**
 * 自定义常量
 */
public class TimeTableExcelUtils {


    public static void drawingLine(int lineType, int row, int col, XSSFDrawing drawingPatriarch) {

        int dx1 = 0;
        int dy1 = 0;
        int dx2 = 0;
        int dy2 = 0;
        int col1 = 0;
        int row1 = 0;
        int col2 = 0;
        int row2 = 0;
        boolean dottedFlag = false;
        switch (lineType) {
            case TimeTableSpecialPlaceConstants.SOLID_LINE_TOP:
                dx1 = 0;
                dy1 = 105000;
                dx2 = 0;
                dy2 = 105000;
                col1 = col;
                row1 = row;
                col2 = col + 1;
                row2 = row;
                break;
            case TimeTableSpecialPlaceConstants.SOLID_LINE_BOTTOM:
                dx1 = 0;
                dy1 = 270000;
                dx2 = 0;
                dy2 = 270000;
                col1 = col;
                row1 = row;
                col2 = col + 1;
                row2 = row;
                break;
            case TimeTableSpecialPlaceConstants.SOLID_LINE_LEFT:
                dx1 = 150000;
                dy1 = 0;
                dx2 = 150000;
                dy2 = 0;
                col1 = col;
                row1 = row;
                col2 = col;
                row2 = row + 1;
                break;
            case TimeTableSpecialPlaceConstants.DOTTED_LINE_BOTTOM:
                dx1 = 0;
                dy1 = 270000;
                dx2 = 0;
                dy2 = 270000;
                col1 = col;
                row1 = row;
                col2 = col + 1;
                row2 = row;
                dottedFlag = true;
                break;
            case TimeTableSpecialPlaceConstants.DOTTED_LINE_TOP:
                dx1 = 0;
                dy1 = 105000;
                dx2 = 0;
                dy2 = 105000;
                col1 = col;
                row1 = row;
                col2 = col + 1;
                row2 = row;
                dottedFlag = true;
                break;
            default:
                System.err.println("参数输入错误 ");
                break;
        }
        XSSFClientAnchor anchor = new XSSFClientAnchor(dx1, dy1, dx2, dy2, col1, row1, col2, row2);
        XSSFSimpleShape line = drawingPatriarch.createSimpleShape(anchor);
        line.setShapeType(ShapeTypes.LINE);
        if (dottedFlag) {
            line.setLineStyle(ShapeTypes.LINE_INV);
        }
        line.setLineStyleColor(0, 0, 0);
        line.setLineWidth(1.2);
    }

}
