package com.goisan.tabular.dao;

import com.goisan.educational.major.bean.Major;
import com.goisan.tabular.bean.TabularFile;
import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

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
