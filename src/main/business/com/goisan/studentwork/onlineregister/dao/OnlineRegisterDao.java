package com.goisan.studentwork.onlineregister.dao;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OnlineRegisterDao {

    List<OnlineRegister> getOnlineRegisterList(OnlineRegister onlineRegister);

    void saveOnlineRegister(BaseBean baseBean);

    OnlineRegister getOnlineRegisterById(String id);

    void updateOnlineRegister(OnlineRegister onlineRegister);

    void delOnlineRegister(String id);

    List<OnlineRegister> getRegisterByIDCard(OnlineRegister onlineRegister);

    List<String> getAllYear();

    List<OnlineRegister> exportOnlineRegisterList(OnlineRegister onlineRegister);

    void audit(@Param("id") String id, @Param("flag")String flag, @Param("mind")String mind);

    void dataCopy(@Param("id") String id, @Param("creator")String creator, @Param("createDept")String createDept);
}
