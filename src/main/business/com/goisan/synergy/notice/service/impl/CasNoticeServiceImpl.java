package com.goisan.synergy.notice.service.impl;

import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.dao.CasNoticeDao;
import com.goisan.synergy.notice.service.CasNoticeService;
import com.goisan.workflow.bean.IndexUnAudti;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CasNoticeServiceImpl implements CasNoticeService {

    @Resource
    private CasNoticeDao casNoticeDao;

    @Override
    public List<Notice> CasNoticeListIndexNotice(String loginID, String deptId, String level) {
        return casNoticeDao.CasNoticeListIndexNotice(loginID,deptId,level);
    }

    @Override
    public String selectUserAccount(String userName) {
        return casNoticeDao.selectUserAccount(userName);
    }

    @Override
    public String selectDeptId(String s) {
        return casNoticeDao.selectDeptId(s);
    }

    @Override
    public String selectLevel(String s) {
        return casNoticeDao.selectLevel(s);
    }

    @Override
    public String selectPersonId(String s) {
        return casNoticeDao.selectPersonId(s);
    }

    @Override
    public List<IndexUnAudti> selectIndexUnAudtiList(String personId) {
        return casNoticeDao.selectIndexUnAudtiList(personId);
    }
}
