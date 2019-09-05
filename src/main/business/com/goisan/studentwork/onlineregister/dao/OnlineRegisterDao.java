package com.goisan.studentwork.onlineregister.dao;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface OnlineRegisterDao {

    List<OnlineRegister> getOnlineRegisterList(OnlineRegister onlineRegister);

    void saveOnlineRegister(BaseBean baseBean);

    OnlineRegister getOnlineRegisterById(String id);

    void updateOnlineRegister(OnlineRegister onlineRegister);

    void delOnlineRegister(String id);

    List<OnlineRegister> getRegisterByIDCard(OnlineRegister onlineRegister);

    List<String> getAllYear();

}
