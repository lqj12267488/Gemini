package com.goisan.system.service;

import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.TalentRecruitment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TalentRecruitmentService {
    List<TalentRecruitment> getTalentRecruitmentList(TalentRecruitment talentRecruitment);

    void insertTalentRecruitment(TalentRecruitment talentRecruitment);

    TalentRecruitment getTalentRecruitmentById(String id);

    void updateTalentRecruitmentById(TalentRecruitment TalentRecruitment);

    void deleteTalentRecruitmentById(String id);

    List<AutoComplete> autoCompleteDept();

    List<AutoComplete> autoCompleteEmployee();

    List<TalentRecruitment> getProcessList(TalentRecruitment talentRecruitment);

    List<TalentRecruitment> getCompleteList(TalentRecruitment talentRecruitment);

    String getPersonNameById(String personId);

    String getDeptNameById(String deptId);

    String getPostByPersonId(String personId);

    String getTalentRecruitmentHandleDateById(@Param("id") String id, @Param("roleName") String roleName);

    String getTalentRecruitmentHandleRemarkById(@Param("id") String id, @Param("roleName") String roleName);
}
