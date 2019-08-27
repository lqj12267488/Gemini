package com.goisan.synergy.notice.dao;

import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.system.bean.Emp;
import com.goisan.task.bean.SysTask;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/5/11.
 */
@Repository
public interface NoticeDao {

    Notice getNoticeById(String id);

    List<Notice> getNoticeList(Notice notice);

    List<Notice> getNoticeListes(Notice notice);

    List<Notice> getNoticeListApp(String personId);

    List<Notice> getReceiptPerson(Notice notice);

    List<Notice> getReadPersonByNoticeId(String id);

    void insertNotice(Notice notice);

    void updateNotice(Notice notice);

    void deleteNoticeLog(String id);

    void deleteNoticeDaoById(String id);

    List<Notice> getNoticeListPerson(@Param("loginID") String loginID, @Param("deptId") String deptId,@Param("level") String level);

    List<Notice> getNoticeMoreList(@Param("loginID") String loginID, @Param("deptId") String deptId,@Param("level") String level);

    List<Notice> getNoticeMoreReaded(@Param("loginID") String loginID, @Param("deptId") String deptId,@Param("level") String level);

    List<Notice> getNoticeListPar(@Param("loginID") String loginID, @Param("deptId") String deptId,  @Param("classlist") List classlist);

    List<Message> getNoticeAppList(@Param("personId") String personId,@Param("deptId") String deptId);

    List<Notice> getBulletinAppList(String loginID);

    List<Notice> selectNoticeLog(Notice notice);

    void insertNoticeLog(Notice notice);

    void inserApptNoticeLog(Notice notice);

    List<Message> getNoticeCountApp(@Param("personId") String personId,@Param("deptId") String deptId);

    List<Notice> getBulletinCountApp(String personId);

    SysTask getTask(String id);
    List<Notice> getProcessList(Notice notice);

    List<Notice> getNoticeComplete(Notice notice);

    List<Notice> getNoticeRequest(Notice notice);

    void updatePublishFlag(String id);

    void updateNoticeAPP(Notice notice);

    List<Emp> getEmpByDeptIds(@Param("id")String  id);

    void deleteNullMessage(String id);
    void noticePublish(String id);

    String getNoticeConcentById(String id);
}
