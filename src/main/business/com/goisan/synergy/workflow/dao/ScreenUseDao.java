package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.ScreenUse;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/6/28.
 */
@Repository
public interface ScreenUseDao {
    List<ScreenUse> screenUseAction(ScreenUse screenUse);//
    String getPersonNameById(String personId);//通过ID获取申请人
    String getDeptNameById(String deptId);//通过ID获取部门名称
    ScreenUse getScreenUseById(String id);//通过ID获取大屏幕
    void insertScreenUse(ScreenUse screenUse);//添加
    void updateScreenUse(ScreenUse screenUse);//更新
    void deleteScreenUseById(String id);//删除
    List<AutoComplete> selectDept();//自动完成框_部门
    List<AutoComplete> selectPerson();//自动完成框_人员
    List<ScreenUse> getScreenUseListProcess(ScreenUse screenUse);
    List<ScreenUse> getScreenUseListComplete(ScreenUse screenUse);
}
