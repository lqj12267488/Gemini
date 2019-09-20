package com.goisan.tabular.service;

import com.goisan.educational.major.bean.Major;
import com.goisan.tabular.bean.TabularFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface TableAttributeService {
    void expertExcel_A1(HttpServletResponse response, TabularFile tabularFile);

    /**
     * modify by yinzijian start
     */
    void expertExcel_A7_6_1(HttpServletResponse response, TabularFile tabularFile);
    List<Major> getZhaoshengList();

    void expertExcel_A7_6_2(HttpServletResponse response, TabularFile tabularFile);
    List<Major> getGraduationList();

    void expertExcel_A7_6_3(HttpServletResponse response, TabularFile tabularFile);
    List<Major> getPastgraduationList();
    /**
     * modify by yinzijian end
     */
}
