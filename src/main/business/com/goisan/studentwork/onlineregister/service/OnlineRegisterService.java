package com.goisan.studentwork.onlineregister.service;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface OnlineRegisterService {

    List<OnlineRegister> getOnlineRegisterList(OnlineRegister onlineRegister);

    void saveOnlineRegister(OnlineRegister onlineRegister);

    OnlineRegister getOnlineRegisterById(String id);

    void updateOnlineRegister(OnlineRegister onlineRegister);

    void delOnlineRegister(String id);

}