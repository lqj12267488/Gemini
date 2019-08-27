package com.goisan.system.dao;

import com.goisan.system.bean.UserDic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2017/7/12.
 */
public interface DicMappingDao {
    List<UserDic> dicMappingAction(UserDic userDic);
    void insertDicMapping(UserDic userDic);
    void updateDicMapping(UserDic userDic);
    void deleteDicMapping(String id);
    UserDic getDicMappingID(String id);
    UserDic getDicID(String id);
    List<UserDic> getDicMapping(UserDic userDic);
    List<UserDic> dicMappingSearch(UserDic userDic);
    List<UserDic> checkName(UserDic userDic);
    List<UserDic> checkType(UserDic userDic);
    List<UserDic> checkUrl(UserDic userDic);
}
