package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.dao.SchoolCarTypeDao;
import com.goisan.synergy.workflow.service.SchoolCarTypeService;
import com.goisan.system.bean.UserDic;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**学校车辆类型管理
 * Created by wq on 2017/5/26.
 */
@Service
public class SchoolCarTypeServiceImpl implements SchoolCarTypeService {
    @Resource
    private SchoolCarTypeDao schoolCarTypeDao;
    public List<UserDic> schoolCarTypeAction(UserDic userDic) {
        return schoolCarTypeDao.schoolCarTypeAction(userDic);
    }

    public void insertSchoolCarType(UserDic userDic) {
        schoolCarTypeDao.insertSchoolCarType(userDic);
    }
    public void deleteSchoolCarTypeById(String id) {
        schoolCarTypeDao.deleteSchoolCarTypeById(id);
    }
    public void updateSchoolCarType(UserDic userDic) {
        schoolCarTypeDao.updateSchoolCarType(userDic);
    }
    public UserDic getSchoolCarTypeById(String id) {
        return schoolCarTypeDao.getSchoolCarTypeById(id);
    }
    public List<UserDic> getSchoolCarTypeList(UserDic userDic) {
        return schoolCarTypeDao.getSchoolCarTypeList(userDic);
    }

    public List<UserDic> checkName(UserDic userDic) {
        return schoolCarTypeDao.checkName(userDic);
    }
    public List<UserDic> checkCode(UserDic userDic) {
        return schoolCarTypeDao.checkCode(userDic);
    }
    public List<UserDic> checkOrder(UserDic userDic) {
        return schoolCarTypeDao.checkOrder(userDic);
    }

    public List<String> getSchoolCarTypeNoOrder(){return schoolCarTypeDao.getSchoolCarTypeNoOrder();}
}
