package com.goisan.tabular.dao;

import com.goisan.tabular.bean.TabularFile;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletResponse;

@Repository
public interface TableAttributeDao {
    void expertExcel_A1(HttpServletResponse response, TabularFile tabularFile);
    /**
     * modify by lihanyue start
     */
    void InstitutionalSetup();//A1-6机构设置表
    /**
     * modify by lihanyue end
     */
}
