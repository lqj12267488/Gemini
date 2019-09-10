package com.goisan.synergy.notice.dao;

import com.goisan.synergy.notice.bean.Notice;
import com.goisan.workflow.bean.IndexUnAudti;

import java.util.List;

public interface CasNoticeDao {
    public List<Notice> CasNoticeListIndexNotice(String loginID, String deptId, String level) ;

    String selectUserAccount(String userName);

    String selectDeptId(String userName);

    String selectLevel(String userName);

    String selectPersonId(String userName);

    List<IndexUnAudti> selectIndexUnAudtiList(String id);
}
