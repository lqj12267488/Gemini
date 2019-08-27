package com.goisan.synergy.notice.service.impl;

import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.dao.NoticeDao;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.system.bean.Emp;
import com.goisan.task.bean.SysTask;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/5/11.
 */
@Service
public class NoticeServiceImpl implements NoticeService {
    @Resource
    private NoticeDao noticeDao;

    public List<Notice> getReceiptPerson(Notice notice) {
        return noticeDao.getReceiptPerson(notice);
    }

    public List<Notice> getReadPersonByNoticeId(String id){
        return noticeDao.getReadPersonByNoticeId(id);
    }

    public Notice getNoticeById(String id){
        return noticeDao.getNoticeById(id);
    }

    public List<Notice> getNoticeListApp(String personId) {
        return noticeDao.getNoticeListApp(personId);
    }

    public List<Notice> getNoticeList(Notice notice){
        return noticeDao.getNoticeList(notice);
    }

    public List<Notice> getNoticeListes(Notice notice){
        return noticeDao.getNoticeListes(notice);
    }

    public void insertNotice(Notice notice){
        noticeDao.insertNotice(notice);
    }

    public void updateNotice(Notice notice){
        noticeDao.updateNotice(notice);
    }

    @Override
    public void deleteNoticeLog(String id) {
        noticeDao.deleteNoticeLog(id);
    }

    public void deleteNoticeDaoById(String id){
        noticeDao.deleteNoticeDaoById(id);
    }

    public List<Notice> getNoticeListPerson( String loginID, String deptId,String level){
        return noticeDao.getNoticeListPerson(loginID,deptId,level);
    }

    public List<Notice> getNoticeListPar( String loginID, String deptId,List classlist){
        return noticeDao.getNoticeListPar(loginID,deptId, classlist);
    }

    public List<Message> getNoticeAppList(String personId,String deptId) {
        return noticeDao.getNoticeAppList(personId,deptId);
    }

    public List<Notice> getBulletinAppList(String loginID) {
        return noticeDao.getBulletinAppList(loginID);
    }

    public List<Notice> selectNoticeLog(Notice notice) {
        return noticeDao.selectNoticeLog(notice);
    }

    public void insertNoticeLog(Notice notice) {
        noticeDao.insertNoticeLog(notice);
    }

    public void inserApptNoticeLog(Notice notice) {
        noticeDao.insertNoticeLog(notice);
    }

    public List<Message> getNoticeCountApp(String personId,String deptId) {
        return noticeDao.getNoticeCountApp(personId,deptId);
    }

    public List<Notice> getBulletinCountApp(String personId) {
        return noticeDao.getBulletinCountApp(personId);
    }

    public SysTask getTask(String id) {
        return noticeDao.getTask(id);
    }
    public List<Notice> getProcessList(Notice notice) {
        return noticeDao.getProcessList(notice);
    }

    public List<Notice> getNoticeComplete(Notice notice) {
        return noticeDao.getNoticeComplete(notice);
    }

    public List<Notice> getNoticeRequest(Notice notice) {
        return noticeDao.getNoticeRequest(notice);
    }

    public void updatePublishFlag(String id) {
        noticeDao.updatePublishFlag(id);
    }

    @Override
    public void updateNoticeAPP(Notice notice) {
        noticeDao.updateNoticeAPP(notice);
    }

    @Override
    public List<Emp> getEmpByDeptIds(String id) {
        return noticeDao.getEmpByDeptIds(id);
    }

    @Override
    public List<Notice> getNoticeMoreList(String loginID, String deptId,String level) {
        return noticeDao.getNoticeMoreList(loginID,deptId,level);
    }
    @Override
    public List<Notice> getNoticeMoreReaded(String loginID, String deptId,String level) {
        return noticeDao.getNoticeMoreReaded(loginID,deptId,level);
    }

    @Override
    public void noticePublish(String id) {
        noticeDao.noticePublish(id);
    }

    @Override
    public String getNoticeConcentById(String id) {
        return noticeDao.getNoticeConcentById(id);
    }
}
