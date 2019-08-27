package com.goisan.system.service.impl;

import com.goisan.system.bean.Tree;
import com.goisan.system.bean.UserDic;
import com.goisan.system.dao.UserDicDao;
import com.goisan.system.service.UserDicService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/5/25.
 */
@Service
public class UserDicServiceImpl implements UserDicService {
    @Resource
    private UserDicDao userDicDao;
    public String selectDicType(String dictype) {
        return userDicDao.selectDicType(dictype);
    }
    public String selectName(String name) {
        return userDicDao.selectName(name);
    }

    @Override
    public String getMaxDicOrder(String dictype) {
        return userDicDao.getMaxDicOrder(dictype);
    }

    @Override
    public String getMaxDicCode(String dictype) {
        return userDicDao.getMaxDicCode(dictype);
    }

    public List<UserDic> userDicAction(String dictype) {
        return userDicDao.userDicAction(dictype);
    }
    public void insertUserDic(UserDic userDic) {
        userDicDao.insertUserDic(userDic);
    }

    @Override
    public void saveRepairGoods(UserDic userDic) {
        userDicDao.saveRepairGoods(userDic);
    }

    @Override
    public void updateRepairGoods(UserDic userDic) {
        userDicDao.updateRepairGoods(userDic);
    }

    public UserDic getUserDicById(String id,String dictype) {
        return userDicDao.getUserDicById(id,dictype);
    }

    public void updateUserDicSupplies(UserDic userDic) {
        userDicDao.updateUserDicSupplies(userDic);
    }
    public void deleteUserDicById(String id) {
        userDicDao.deleteUserDicById(id);
    }

    @Override
    public void delRepairGoods(String id) {
        userDicDao.delRepairGoods(id);
    }

    public List<UserDic> getUserDicComplete(UserDic userDic) {
        return userDicDao.getUserDicComplete(userDic);
    }
    public List<UserDic> checkName(UserDic userDic) {
        return userDicDao.checkName(userDic);
    }

    public List<UserDic> checkCode(UserDic userDic) {
        return userDicDao.checkCode(userDic);
    }

    public List<UserDic> checkOrder(UserDic userDic) {
        return userDicDao.checkOrder(userDic);
    }

    @Override
    public List<Tree> getDicTree(String dicType) {
        return userDicDao.getDicTree(dicType);
    }

    @Override
    public String getDicName(String uid) {
        return userDicDao.getDicName(uid);
    }

    @Override
    public String getNewTypeId(String pId, String dictype) {
        String id = userDicDao.getMaxTypeid(pId,dictype);
        return CommonUtil.getnextId(id, pId);
    }
}
