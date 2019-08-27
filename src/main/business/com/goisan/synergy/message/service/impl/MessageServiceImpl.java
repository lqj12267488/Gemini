package com.goisan.synergy.message.service.impl;

import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.message.dao.MessageDao;
import com.goisan.synergy.message.service.MessageService;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.dao.NoticeDao;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.tools.CommonUtil;
import com.goisan.task.bean.SysTask;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/11.
 */
@Service
public class MessageServiceImpl implements MessageService {
    @Resource
    private MessageDao messageDao;

    public Message getReceiptPersonByMessageId(String id) {
        return messageDao.getReceiptPersonByMessageId(id);
    }

    public List<Message> getReadPersonByMessageId(String id){
        return messageDao.getReadPersonByMessageId(id);
    }

    public List<Message> getReceiptListByDeptId(String deptId){
//        return messageDao.getReceiptListByDeptId(deptId);
        return null ;
    }

    public List<Message> getReceiptListByPersonId(String personId){
//        return messageDao.getReceiptListByPersonId(personId);
        return null ;
    }

    @Override
    public List<Message> getMessageRequest(Message message) {
        return messageDao.getMessageRequest(message);
    }

    @Override
    public void updatePublishFlag(String id) {
        messageDao.updatePublishFlag(id);
    }

    @Override
    public void messagePublish(String id) {
        messageDao.messagePublish(id);
    }

    @Override
    public List<Message> getProcessList(Message message) {
        return messageDao.getProcessList(message);
    }

    @Override
    public List<Message> getMessageComplete(Message message) {
        return messageDao.getMessageComplete(message);
    }

    @Override
    public void updateMessage(Message message) {
        messageDao.updateMessage(message);
    }

    @Override
    public void deleteNullMessage(String id) {
        messageDao.deleteNullMessage(id);
    }

    public List<Message> getMessageList(Message message){
        return messageDao.getMessageList(message);
    }

    @Override
    public List<Message> getMessageListes(Message message) {
        return messageDao.getMessageListes(message);
    }

    public void insertMessage(Message message){
        messageDao.insertMessage(message);
    }

    public void insertMessageLog(Message message) {
        messageDao.insertMessageLog(message);
    }

    public List<Tree> getEmpTree() {
        return messageDao.getEmpTree();
    }

    public List<Message> getDeptPersonId(String deptId) {
        return messageDao.getDeptPersonId(deptId);
    }

    public void deleteMessage(String id) {
        messageDao.deleteMessage(id);
    }

    public void deleteMessageLog(String id) {
        messageDao.deleteMessageLog(id);
    }

    public Message getMessageById(String id) {
        return messageDao.getMessageById(id);
    }

    public void updateMessageLog(String id) {
        messageDao.updateMessageLog(id);
    }

    public List<Message> getMessagePersonList(String id){
        Message receiptPerson =messageDao.getReceiptPersonByMessageId(id);
        List<Message> readPersonList =messageDao.getReadPersonByMessageId(id);
        List<Message> receiptPersonList =new ArrayList<Message>();
//        String[] stuId = receiptPerson.getStuId().split(",");

        int num = 0;
        List list = new ArrayList();

        // 教职工--整部门
        if(null != receiptPerson.getDeptId() && !receiptPerson.getDeptId().equals("")){
            String[] deptId = receiptPerson.getDeptId().split(",");
            for( num = 0; num <deptId.length ;num++) {
                list.add(deptId[num]);
                if((num +1)% 100 ==0){
                    List<Message> deptPerson = messageDao.getReceiptListByDeptId(list);
                    if (deptPerson.size() != 0) {
                        receiptPersonList.addAll(deptPerson);
                    }
                    list = new ArrayList();
                }
            }
            if( (num +1) % 100 !=0){
                List<Message> deptPerson = messageDao.getReceiptListByDeptId(list);
                if (deptPerson.size() != 0) {
                    receiptPersonList.addAll(deptPerson);
                }
                list = new ArrayList();
            }
        }

        // 教职工
        if(null != receiptPerson.getEmpId() && !receiptPerson.getEmpId().equals("")) {
            String[] empId = receiptPerson.getEmpId().split(",");
            for( num = 0; num <empId.length ;num++) {
                if (empId[num].length() > 35) {
                    list.add(empId[num]);
                }
                if((num +1) % 100 ==0){
                    List<Message> deptPerson = messageDao.getReceiptListByPersonId(list);
                    if (deptPerson.size() != 0) {
                        receiptPersonList.addAll(deptPerson);
                    }
                    list = new ArrayList();
                }
            }
            if( (num +1) % 100 !=0){
                List<Message> deptPerson = messageDao.getReceiptListByPersonId(list);
                if (deptPerson.size() != 0) {
                    receiptPersonList.addAll(deptPerson);
                }
                list = new ArrayList();
            }
        }

        /*// 家长 --正班
        if(null != receiptPerson.getParId() && !receiptPerson.getParId().equals("")) {
            String[] parId = receiptPerson.getParId().split(",");
            for( num = 0; num <parId.length ;num++) {
                list.add(parId[num]);
                if((num +1) % 100 ==0){
                    List<Message> deptPerson = messageDao.getReceiptListByParId(list);
                    if (deptPerson.size() != 0) {
                        receiptPersonList.addAll(deptPerson);
                    }
                    list = new ArrayList();
                }
            }
            if( (num +1) % 100 !=0 ){
                List<Message> deptPerson = messageDao.getReceiptListByParId(list);
                if (deptPerson.size() != 0) {
                    receiptPersonList.addAll(deptPerson);
                }
                list = new ArrayList();
            }
        }*/

        for (int i=0;i<receiptPersonList.size();i++){
            if(readPersonList.size()==0){
                receiptPersonList.get(i).setRange("未读");
            }else{
                for (int j = 0; j < readPersonList.size(); j++){
                    if((receiptPersonList.get(i).getEmpId()).equals(readPersonList.get(j).getEmpId())){
                        receiptPersonList.get(i).setRange("已读");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        String tsStr="";
                        try {
                            tsStr = sdf.format(readPersonList.get(j).getCreateTime());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        receiptPersonList.get(i).setAbc(tsStr);
                        break;
                    }else{
                        receiptPersonList.get(i).setRange("未读");
                    }
                }
            }
        }
        return receiptPersonList;
    }

    @Override
    public List<Message> getMessageListPerson(String loginID, String deptId) {
        return messageDao.getMessageListPerson(loginID,deptId);
    }

    @Override
    public List<Message> getMessageMoreList(String loginID, String deptId) {
        return messageDao.getMessageMoreList(loginID,deptId);
    }

    @Override
    public List<Message> getMessageMoreReaded(String loginID, String deptId) {
        return messageDao.getMessageMoreReaded(loginID,deptId);
    }
}
