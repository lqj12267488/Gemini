package com.goisan.synergy.maillist.service;

import com.goisan.synergy.maillist.bean.MailList;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by wq on 2017/10/24.
 */
public interface MailListService {
    List<MailList> getMailList(MailList mailList);
    List<AutoComplete> getAutoCompleteDept();
    List<AutoComplete> getAutoCompleteEmployee();
}
