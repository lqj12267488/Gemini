package com.goisan.tabular.service;

import com.goisan.tabular.bean.TabularFile;

import javax.servlet.http.HttpServletResponse;

public interface TableAttributeService {
    void expertExcel_A1(HttpServletResponse response, TabularFile tabularFile);
}
