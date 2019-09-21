package com.goisan.tabular.service;

import com.goisan.tabular.bean.TabularFile;

import javax.servlet.http.HttpServletResponse;

public interface TableAttributeService {
    void expertExcel_A1(HttpServletResponse response, TabularFile tabularFile);

    void   expertExcel_A7_3_1(HttpServletResponse response,TabularFile tabularFile);

    void   expertExcel_A7_3_2(HttpServletResponse response,TabularFile tabularFile);

    void   expertExcel_A7_4(HttpServletResponse response,TabularFile tabularFile);

//    void   expertExcel_A7(HttpServletResponse response,TabularFile tabularFile);

}
