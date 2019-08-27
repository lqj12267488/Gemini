package com.goisan.synergy.message.dao;

import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.task.bean.SysTask;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/5/11.
 */
@Repository
public interface MessageDao {

    //Notice getNoticeById(String id);

    List<Message> getMessageList(Message message);

    List<Message> getMessageListes(Message message);

    /*List<Notice> getNoticeListApp(String personId);*/

    void insertMessage(Message message);

    void insertMessageLog(Message message);

    List<Tree> getEmpTree();

    List<Message> getDeptPersonId(String deptId);

    void deleteMessage(String id);

    void deleteMessageLog(String id);

    Message getMessageById(String id);

    void updateMessageLog(String id);

    Message getReceiptPersonByMessageId(String id);

    List<Message> getReadPersonByMessageId(String id);

    List<Message> getReceiptListByDeptId(@Param("deptId")List deptId);

    List<Message> getReceiptListByPersonId(@Param("personId")List personId);

    List<Message> getReceiptListByParId(@Param("parId")List parId);

    List<Message> getMessageRequest(Message message);

    void updatePublishFlag(String id);

    void messagePublish(String id);

    List<Message> getProcessList(Message message);

    List<Message> getMessageComplete(Message message);
    void updateMessage(Message message);

    void deleteNullMessage(String id);

    List<Message> getMessageListPerson(@Param("loginID") String loginID, @Param("deptId") String deptId);

    List<Message> getMessageMoreList(@Param("loginID") String loginID, @Param("deptId") String deptId);

    List<Message> getMessageMoreReaded(@Param("loginID") String loginID, @Param("deptId") String deptId);
}
