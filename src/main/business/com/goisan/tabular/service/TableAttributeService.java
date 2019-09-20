package com.goisan.tabular.service;

import com.goisan.educational.major.bean.Major;
import com.goisan.educational.skillappraisal.bean.SkillAppraisal;
import com.goisan.evaluation.bean.EvaluationTask;
import com.goisan.system.bean.Dept;
import com.goisan.system.bean.Emp;
import com.goisan.tabular.bean.TabularFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface TableAttributeService {

    /**
     * modify by lihanyue start
     */
    void expertExcel_A1(HttpServletResponse response, TabularFile tabularFile);
    void expertExcel_A1_6(HttpServletResponse response,TabularFile tabularFile);//A1-6机构设置表
    List<Dept> getExpertExcel_A1_6();
    void expertExcel_A2(HttpServletResponse response,TabularFile tabularFile);//A2院校领导表
    List<Emp> getExpertExcel_A2();
    void expertExcel_A3(HttpServletResponse response,TabularFile tabularFile);//A3基本办学条件表1
    void expertExcel_A4_1(HttpServletResponse response,TabularFile tabularFile);//A4-1校内实线基地表
    void expertExcel_A4_2(HttpServletResponse response,TabularFile tabularFile);//A4-2校外实习实训基地表1
    void expertExcel_A4_3(HttpServletResponse response,TabularFile tabularFile);//A4-3职业技能鉴定机构部1
    List<SkillAppraisal> getExpertExcel_A4_3();
    void expertExcel_A5_1(HttpServletResponse response,TabularFile tabularFile);//A5-1经费收入表1
    void expertExcel_A5_2(HttpServletResponse response,TabularFile tabularFile);//A5-2经费支出表1

    void expertExcel_A8_1(HttpServletResponse response, TabularFile tabularFile);//A8-1教学与学生管理文件表1	    

    void expertExcel_A8_2(HttpServletResponse response, TabularFile tabularFile);//A8-2专职教学管理人员情况表1

    List<Emp> getExpertExcel_A8_2();

    void expertExcel_A8_3(HttpServletResponse response, TabularFile tabularFile);//A8-3专职学生管理人员情况表1

    List<Emp> getExpertExcel_A8_3();

    void expertExcel_A8_4(HttpServletResponse response, TabularFile tabularFile);//A8-4专职招生就业指导人员情况表1	    

    List<Emp> getExpertExcel_A8_4();

    void expertExcel_A8_5(HttpServletResponse response, TabularFile tabularFile);//A8-5专职督导人员情况表1	    

    List<Emp> getExpertExcel_A8_5();

    void expertExcel_A8_6(HttpServletResponse response, TabularFile tabularFile);//A8-6专职教学研究人员情况表1		    

    List<Emp> getExpertExcel_A8_6();

    void expertExcel_A8_7(HttpServletResponse response, TabularFile tabularFile);//A8-7评教情况表1		    

    List<EvaluationTask> getExpertExcel_A8_7(String term);

    void expertExcel_A8_8(HttpServletResponse response, TabularFile tabularFile);//A8-8奖助学情况表1	    

    void expertExcel_A8_9(HttpServletResponse response, TabularFile tabularFile);//A8-9重大制度创新表1
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

    /**
     * modify by lizhipeng start
     */

    /**
     * modify by lizhipeng end
     */

    /**
     * modify by hanjie start
     */

    /**
     * modify by hanjie end
     */

    /**
     * modify by wangxue start
     */

    /**
     * modify by wangxue end
     */
}
