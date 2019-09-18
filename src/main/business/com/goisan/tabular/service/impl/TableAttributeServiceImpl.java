package com.goisan.tabular.service.impl;

import com.goisan.educational.major.bean.TalentTrain;
import com.goisan.educational.major.bean.TeachingTeamMember;
import com.goisan.system.bean.CommonBean;
import com.goisan.tabular.bean.TabularFile;
import com.goisan.tabular.dao.TableAttributeDao;
import com.goisan.tabular.service.TableAttributeService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import static com.goisan.tabular.controller.TabularController.COM_REPORT_PATH;

@Service
public class TableAttributeServiceImpl implements TableAttributeService {
    @Resource
    private TableAttributeDao tableAttributeDao;

    /**
     * 导出带有数据得表格 命名expertExcel_A加上数字
     * 例
     * * @param response
     */
    public void expertExcel_A1(HttpServletResponse response,TabularFile tabularFile){
        String filePath = COM_REPORT_PATH + tabularFile.getFileUrl();
        File file = FileUtils.getFile(filePath);
        OutputStream os = null;
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(tabularFile.getFileName(),
                    "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
