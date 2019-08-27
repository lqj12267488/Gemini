package com.goisan.synergy.maillist.dao;

import com.goisan.synergy.maillist.bean.MailList;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wq on 2017/10/24.
 */
@Repository
public interface MailListDao {
    List<MailList> getMailList(MailList mailList);
    List<AutoComplete> getAutoCompleteDept();
    List<AutoComplete> getAutoCompleteEmployee();
}
