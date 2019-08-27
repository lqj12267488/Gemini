package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.NewsDraft;
import com.goisan.synergy.workflow.dao.NewsDraftDao;
import com.goisan.synergy.workflow.service.NewsDraftService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**新闻稿发布管理
 * Created by wq on 2017/7/20.
 */
@Service
public class NewsDraftServiceImpl implements NewsDraftService{
    @Resource
    private NewsDraftDao newsDraftDao;

    public List<NewsDraft> getNewsDraftList(NewsDraft newsDraft) {
        return newsDraftDao.getNewsDraftList(newsDraft);
    }

    public void insertNewsDraft(NewsDraft newsDraft) {
        newsDraftDao.insertNewsDraft(newsDraft);
    }

    public void deleteNewsDraft(String id) {
        newsDraftDao.deleteNewsDraft(id);
    }

    public void updateNewsDraft(NewsDraft newsDraft) {
        newsDraftDao.updateNewsDraft(newsDraft);
    }

    public NewsDraft getNewsDraftById(String id) {
        return newsDraftDao.getNewsDraftById(id);
    }

    public List<NewsDraft> getNewsDraftProcessList(NewsDraft newsDraft) {
        return newsDraftDao.getNewsDraftProcessList(newsDraft);
    }

    public List<NewsDraft> getNewsDraftCompleteList(NewsDraft newsDraft) {
        return newsDraftDao.getNewsDraftCompleteList(newsDraft);
    }

    public List<AutoComplete> selectPerson() {
        return newsDraftDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return newsDraftDao.selectDept();
    }

    public String getPersonNameById(String personId) {
        return  newsDraftDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return newsDraftDao.getDeptNameById(deptId);
    }

    public List<Select2> getDeptPerson(String deptId) {
        return newsDraftDao.getDeptPerson(deptId);
    }
}
