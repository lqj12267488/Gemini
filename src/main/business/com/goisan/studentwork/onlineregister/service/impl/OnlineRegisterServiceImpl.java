package com.goisan.studentwork.onlineregister.service.impl;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.studentwork.onlineregister.dao.OnlineRegisterDao;
import com.goisan.studentwork.onlineregister.service.OnlineRegisterService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OnlineRegisterServiceImpl implements OnlineRegisterService {

    @Resource
    private OnlineRegisterDao onlineRegisterDao;

    @Override
    public List<OnlineRegister> getOnlineRegisterList(OnlineRegister onlineRegister) {
        return onlineRegisterDao.getOnlineRegisterList(onlineRegister);
    }

    @Override
    public void saveOnlineRegister(OnlineRegister onlineRegister) {
        onlineRegisterDao.saveOnlineRegister(onlineRegister);
    }

    @Override
    public OnlineRegister getOnlineRegisterById(String id) {
        return onlineRegisterDao.getOnlineRegisterById(id);
    }

    @Override
    public void updateOnlineRegister(OnlineRegister onlineRegister) {
        onlineRegisterDao.updateOnlineRegister(onlineRegister);
    }

    @Override
    public void delOnlineRegister(String id) {
        onlineRegisterDao.delOnlineRegister(id);
    }
}
