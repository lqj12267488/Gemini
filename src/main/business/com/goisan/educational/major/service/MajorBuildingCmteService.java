package com.goisan.educational.major.service;

import com.goisan.educational.major.bean.MajorBuildingCmte;
import com.goisan.educational.major.bean.MajorBuliedingExcel;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Result;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 专业建设指导委员会
 * @date 2018/9/30 10:08
 */
public interface MajorBuildingCmteService {
    /**
     * 保存成员
     * @param majorBuildingCmte
     */
    Result save(MajorBuildingCmte majorBuildingCmte);

    /**
     * 删除成员
     * @param id
     */
    boolean delete(String id);

    /**
     * 按id查找成员
     * @param id
     * @return
     */
    MajorBuildingCmte getById(String id);

    /**
     * 按条件查找成员表
     * @param majorBuildingCmte
     * @return
     */
    List<MajorBuildingCmte> getList(MajorBuildingCmte majorBuildingCmte);

    /**
     * 按人员id匹配部分信息
     * @param personId
     * @return
     */
    MajorBuildingCmte matchingInfoByPersonId(String personId);

    /**
     * 查询专业表
     * @return
     */
    List<AutoComplete> getMajorList();

    /**
     * 查询教师人员表
     * @return
     */
    List<AutoComplete> getTeacherList();

    /**
     * 每个专业导出一个成员表
     * @return
     */
    List<MajorBuliedingExcel> getCmteListGroupByMajor();

    /**
     * 由专业名获取专业id
     * @param majorName
     * @return
     */
    List<String> getMajorIdByMajorName(String majorName);

    /**
     * 由姓名获取人员id
     * @param name
     * @return
     */
    List<String> getPersonIdByName(String name);

    /**
     * 导出excel
     */
    void expertExcel(HttpServletResponse response);
}
