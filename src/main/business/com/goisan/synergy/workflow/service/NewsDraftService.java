package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.NewsDraft;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;

import java.util.List;

/**新闻稿发布管理
 * Created by wq on 2017/7/20.
 */
public interface NewsDraftService {
    List<NewsDraft> getNewsDraftList(NewsDraft newsDraft);
    void insertNewsDraft(NewsDraft newsDraft);
    void deleteNewsDraft(String id);
    void updateNewsDraft(NewsDraft newsDraft);
    NewsDraft getNewsDraftById(String id);
    List<NewsDraft> getNewsDraftProcessList(NewsDraft newsDraft);
    List<NewsDraft> getNewsDraftCompleteList(NewsDraft newsDraft);
    List<AutoComplete> selectPerson();
    List<AutoComplete> selectDept();
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
    List<Select2> getDeptPerson(String deptId);
}
