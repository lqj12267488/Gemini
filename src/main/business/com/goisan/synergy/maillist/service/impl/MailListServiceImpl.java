package com.goisan.synergy.maillist.service.impl;

import com.goisan.synergy.maillist.bean.MailList;
import com.goisan.synergy.maillist.dao.MailListDao;
import com.goisan.synergy.maillist.service.MailListService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wq on 2017/10/24.
 */
@Service
public class MailListServiceImpl implements MailListService{
    @Resource
    private MailListDao mailListDao;

    public List<MailList> getMailList(MailList mailList){
        return mailListDao.getMailList(mailList);
    }
    public List<AutoComplete> getAutoCompleteDept(){
        return mailListDao.getAutoCompleteDept();
    }
    public List<AutoComplete> getAutoCompleteEmployee(){
        return mailListDao.getAutoCompleteEmployee();
    }
}
