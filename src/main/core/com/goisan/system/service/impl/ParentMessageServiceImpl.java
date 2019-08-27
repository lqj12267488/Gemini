package com.goisan.system.service.impl;

import com.goisan.system.dao.ParentMessageDao;
import com.goisan.system.service.ParentMessageService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ParentMessageServiceImpl implements ParentMessageService {
@Resource
private ParentMessageDao parentMessageDao;

    public List<BaseBean> getParentMessageList(BaseBean baseBean) {
        return parentMessageDao.getParentMessageList(baseBean);
    }

    public void saveParentMessage(BaseBean baseBean) {
        parentMessageDao.saveParentMessage(baseBean);
    }

    public BaseBean getParentMessageById(String id) {
        return parentMessageDao.getParentMessageById(id);
    }

    public void updateParentMessage(BaseBean baseBean) {
        parentMessageDao.updateParentMessage(baseBean);
    }

    public void delParentMessage(String id) {
        parentMessageDao.delParentMessage(id);
    }

    public void delParentMessageChild(String id) {
        parentMessageDao.delParentMessageChild(id);
    }

    public void saveParentMessageLog(BaseBean baseBean){
        parentMessageDao.saveParentMessageLog(baseBean);
    }

    public void  updateParentMessageLog(BaseBean baseBean){
        parentMessageDao.updateParentMessageLog(baseBean);
    }

    public void delParentMessageLog(String id){
        parentMessageDao.delParentMessageLog(id);
    }


    public List<BaseBean> getParentMessageChildById(BaseBean baseBean) {
        return parentMessageDao.getParentMessageChildById(baseBean);
    }

    public List<BaseBean> getParentMessageListByTeacher(BaseBean baseBean){
        return parentMessageDao.getParentMessageListByTeacher(baseBean);
    }

}
