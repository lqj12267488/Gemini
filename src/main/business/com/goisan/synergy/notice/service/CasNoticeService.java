package com.goisan.synergy.notice.service;

import com.goisan.synergy.notice.bean.Notice;
import com.goisan.workflow.bean.IndexUnAudti;

import java.util.List;

public interface CasNoticeService {
    List<Notice> CasNoticeListIndexNotice(String loginID, String deptId, String level);

    String selectUserAccount(String userName);

    String selectDeptId(String s);

    String selectLevel(String s);

    String selectPersonId(String s);

    List<IndexUnAudti> selectIndexUnAudtiList(String personId);
}
