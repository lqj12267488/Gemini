package com.goisan.studentwork.onlineregister.dao;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface OnlineRegisterDao {

    List<OnlineRegister> getOnlineRegisterList(OnlineRegister onlineRegister);

    void saveOnlineRegister(BaseBean baseBean);

    OnlineRegister getOnlineRegisterById(String id);

    void updateOnlineRegister(OnlineRegister onlineRegister);

    void delOnlineRegister(String id);

    List<OnlineRegister> getRegisterByIDCard(OnlineRegister onlineRegister);

    List<String> getAllYear();

    @Select("select * from t_xg_online_register where LANGUAGE = '1'")
    List<OnlineRegister> selectChinese();

    @Select("select * from t_xg_online_register where LANGUAGE = '2'")
    List<OnlineRegister> selectMinkaoHan();

    @Select("select * from t_xg_online_register where LANGUAGE = '3'")
    List<OnlineRegister> selectDoubleLanguage();

    @Select("select dic_name from ( select dic_code, dic_name\n" +
            "          from t_sys_dic a\n" +
            "         where a.parent_id =\n" +
            "               (select id from t_sys_dic s where s.dic_code = 'MZ') and dic_code = #{nation}) ")
    String findMZ(String nation);
}
