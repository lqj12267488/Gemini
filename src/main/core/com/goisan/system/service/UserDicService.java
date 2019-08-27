package com.goisan.system.service;

import com.goisan.system.bean.Tree;
import com.goisan.system.bean.UserDic;

import java.util.List;

/**
 * Created by Administrator on 2017/5/25.
 */
public interface UserDicService {
    String selectDicType(String dictype);
    String selectName(String name);
    String getMaxDicOrder(String dictype);
    String getMaxDicCode(String dictype);
    List<UserDic> userDicAction(String dictype);
    void updateUserDicSupplies(UserDic userDic);
    void deleteUserDicById(String id);
    void delRepairGoods(String id);
    void insertUserDic(UserDic userDic);
    void saveRepairGoods(UserDic userDic);
    void updateRepairGoods(UserDic userDic);
    UserDic getUserDicById(String id,String dictype);
    List<UserDic> getUserDicComplete(UserDic userDic);
    List<UserDic> checkName(UserDic userDic);
    List<UserDic> checkCode(UserDic userDic);
    List<UserDic> checkOrder(UserDic userDic);
    List<Tree> getDicTree(String dicType);
    String getDicName(String uid);
    String getNewTypeId(String pId,String dictype);
}
