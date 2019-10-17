package com.goisan.system.service.impl;

import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.TalentRecruitment;
import com.goisan.system.dao.TalentRecruitmentDao;
import com.goisan.system.service.TalentRecruitmentService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TalentRecruitmentServiceImpl implements TalentRecruitmentService {
    @Resource
    private TalentRecruitmentDao talentRecruitmentDao;

    public List<TalentRecruitment> getTalentRecruitmentList(TalentRecruitment talentRecruitment) {
        return talentRecruitmentDao.getTalentRecruitmentList(talentRecruitment);
    }

    public void insertTalentRecruitment(TalentRecruitment talentRecruitment) {
        talentRecruitmentDao.insertTalentRecruitment(talentRecruitment);
    }

    public TalentRecruitment getTalentRecruitmentById(String id) {
        return talentRecruitmentDao.getTalentRecruitmentById(id);
    }

    public void updateTalentRecruitmentById(TalentRecruitment talentRecruitment) {
        talentRecruitmentDao.updateTalentRecruitmentById(talentRecruitment);
    }

    public void deleteTalentRecruitmentById(String id) {
        talentRecruitmentDao.deleteTalentRecruitmentById(id);
    }

    public List<AutoComplete> autoCompleteDept() {
        return talentRecruitmentDao.autoCompleteDept();
    }

    public List<AutoComplete> autoCompleteEmployee() {
        return talentRecruitmentDao.autoCompleteEmployee();
    }

    public List<TalentRecruitment> getProcessList(TalentRecruitment talentRecruitment) {
        return talentRecruitmentDao.getProcessList(talentRecruitment);
    }

    public List<TalentRecruitment> getCompleteList(TalentRecruitment talentRecruitment) {
        return talentRecruitmentDao.getCompleteList(talentRecruitment);
    }

    public String getPersonNameById(String personId) {
        return talentRecruitmentDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return talentRecruitmentDao.getDeptNameById(deptId);
    }

    public String getPostByPersonId(String personId){
        return talentRecruitmentDao.getPostByPersonId(personId);
    }

    public String getTalentRecruitmentHandleDateById(@Param("id") String id, @Param("roleName") String roleName){
        return talentRecruitmentDao.getTalentRecruitmentHandleDateById(id,roleName);
    }

    public String getTalentRecruitmentHandleRemarkById(@Param("id") String id, @Param("roleName") String roleName){
        return talentRecruitmentDao.getTalentRecruitmentHandleRemarkById(id,roleName);
    }
}
