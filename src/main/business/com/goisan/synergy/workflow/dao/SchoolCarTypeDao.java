package com.goisan.synergy.workflow.dao;

import com.goisan.system.bean.UserDic;
import org.springframework.stereotype.Repository;

import java.util.List;

/**学校车辆类型管理
 * Created by wq on 2017/5/26.
 */
@Repository
public interface SchoolCarTypeDao {
    List<UserDic> schoolCarTypeAction(UserDic userDic);
    void insertSchoolCarType(UserDic userDic);
    void deleteSchoolCarTypeById(String id);
    void updateSchoolCarType(UserDic userDic);
    UserDic getSchoolCarTypeById(String id);
    List<UserDic> getSchoolCarTypeList(UserDic userDic);
    List<UserDic> checkName(UserDic userDic);
    List<UserDic> checkCode(UserDic userDic);
    List<UserDic> checkOrder(UserDic userDic);
    List<String> getSchoolCarTypeNoOrder();
}
