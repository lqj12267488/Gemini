package com.goisan.system.dao;

import com.goisan.system.bean.Tree;
import com.goisan.system.bean.UserDic;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/5/25.
 */
@Repository
public interface UserDicDao {
    String selectDicType(String dictype);
    String selectName(String name);
    String getMaxDicOrder(String dictype);
    String getMaxDicCode(String dictype);
    void insertUserDic(UserDic userDic);
    void saveRepairGoods(UserDic userDic);
    void updateUserDicSupplies(UserDic userDic);
    void deleteUserDicById(String id);
    void updateRepairGoods(UserDic userDic);
    void delRepairGoods(String id);
    List<UserDic> userDicAction(String dictype);
    List<UserDic> getUserDicComplete(UserDic userDic);
    List<UserDic> checkName(UserDic userDic);
    List<UserDic> checkCode(UserDic userDic);
    List<UserDic> checkOrder(UserDic userDic);
    List<Tree> getDicTree(String dicType);
    UserDic getUserDicById(@Param("id") String id,@Param("dictype") String dictype);
    String getDicName(String uid);
    String getMaxTypeid(@Param("pId") String pId,@Param("dictype") String dictype);
}
