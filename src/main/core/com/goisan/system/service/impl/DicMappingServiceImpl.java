package com.goisan.system.service.impl;

import com.goisan.system.bean.UserDic;
import com.goisan.system.dao.DicMappingDao;
import com.goisan.system.service.DicMappingService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/12.
 */
@Service
public class DicMappingServiceImpl implements DicMappingService{
    @Resource
    private DicMappingDao dicMappingDao;
    public List<UserDic> dicMappingAction(UserDic userDic) {
        return dicMappingDao.dicMappingAction(userDic);
    }

    public void insertDicMapping(UserDic userDic) {
        dicMappingDao.insertDicMapping(userDic);
    }

    public void updateDicMapping(UserDic userDic) {
        dicMappingDao.updateDicMapping(userDic);
    }

    public void deleteDicMapping(String id) {
        dicMappingDao.deleteDicMapping(id);
    }

    public UserDic getDicMappingID(String id) {
        return dicMappingDao.getDicMappingID(id);
    }

    public UserDic getDicID(String id) {
        return dicMappingDao.getDicID(id);
    }

    public List<UserDic> getDicMapping(UserDic userDic) {
        return dicMappingDao.getDicMapping(userDic);
    }

    public List<UserDic> dicMappingSearch(UserDic userDic) {
        return dicMappingDao.dicMappingSearch(userDic);
    }

    public List<UserDic> checkName(UserDic userDic) {
        return dicMappingDao.checkName(userDic);
    }

    public List<UserDic> checkType(UserDic userDic) {
        return dicMappingDao.checkType(userDic);
    }

    public List<UserDic> checkUrl(UserDic userDic) {
        return dicMappingDao.checkUrl(userDic);
    }
}
