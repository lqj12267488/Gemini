package com.goisan.synergy.notice.service;

import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.system.bean.Emp;
import com.goisan.task.bean.SysTask;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by admin on 2017/5/11.
 */
public interface NoticeService {
    Notice getNoticeById(String id);

    List<Notice> getReceiptPerson(Notice notice);

    List<Notice> getReadPersonByNoticeId(String id);

    List<Notice> getNoticeListApp(String personId);

    List<Notice> getNoticeList(Notice notice);

    List<Notice> getNoticeListes(Notice notice);

    void insertNotice(Notice notice);

    void updateNotice(Notice notice);

    void deleteNoticeLog(String id);

    void deleteNoticeDaoById(String id);

    List<Notice> getNoticeListPerson(String loginID, String deptId,String level);

    List<Notice> getNoticeListPar(String loginID, String deptId,List classlist);

    List<Message> getNoticeAppList(String personId,String deptId);

    List<Notice> getBulletinAppList(String loginID);

    List<Notice> selectNoticeLog(Notice notice);

    void insertNoticeLog(Notice notice);

    void inserApptNoticeLog(Notice notice);

    List<Message> getNoticeCountApp(String personId,String deptId);

    List<Notice> getBulletinCountApp(String personId);

    SysTask getTask(String id);
    List<Notice> getProcessList(Notice notice);

    List<Notice> getNoticeComplete(Notice notice);

    List<Notice> getNoticeRequest(Notice notice);

    void updatePublishFlag(String id);

    void updateNoticeAPP(Notice notice);

    List<Emp> getEmpByDeptIds(String  id);

    List<Notice> getNoticeMoreList(String loginID,String deptId,String level);

    List<Notice> getNoticeMoreReaded(String loginID, String deptId,String level);

    void noticePublish(String id);

    String getNoticeConcentById(String id);
}
