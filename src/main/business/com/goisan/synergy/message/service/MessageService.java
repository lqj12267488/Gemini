package com.goisan.synergy.message.service;

import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.task.bean.SysTask;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2017/5/11.
 */
public interface MessageService {
    /*Notice getNoticeById(String id);

    List<Notice> getNoticeListApp(String personId);*/

    List<Message> getMessageList(Message message);

    List<Message> getMessageListes(Message message);

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

    List<Message> getReceiptListByDeptId(String deptId);

    List<Message> getReceiptListByPersonId(String personId);

    List<Message> getMessageRequest(Message message);

    void updatePublishFlag(String id);

    void messagePublish(String id);

    List<Message> getProcessList(Message message);

    List<Message> getMessageComplete(Message message);

    void updateMessage(Message message);

    void deleteNullMessage(String id);

    @Transactional
    List<Message> getMessagePersonList(String id);

    List<Message> getMessageListPerson(String loginID,String deptId);

    List<Message> getMessageMoreList(String loginID,String deptId);

    List<Message> getMessageMoreReaded(String loginID,String deptId);

    Message selectMessage(String id);
}
