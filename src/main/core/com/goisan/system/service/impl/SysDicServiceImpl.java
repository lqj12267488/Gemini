package com.goisan.system.service.impl;

import com.goisan.system.bean.SysDic;
import com.goisan.system.dao.SysDicDao;
import com.goisan.system.service.SysDicService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SysDicServiceImpl implements SysDicService{
    @Resource
    private SysDicDao sysDicDao;
    public List<SysDic> sysDicInfo(SysDic sysDic) {
        return sysDicDao.sysDicInfo(sysDic);
    }

    public List<SysDic> sysDicMappingInfo(SysDic sysDic) {
        return sysDicDao.sysDicMappingInfo(sysDic);
    }

    public void insertSysDic(SysDic sysDic) {
        sysDicDao.insertSysDic(sysDic);
    }

    public SysDic getSysDicID(String id) {
        return sysDicDao.getSysDicID(id);
    }

    public void updateSysDic(SysDic sysDic) {
        sysDicDao.updateSysDic(sysDic);
    }

    public void deleteSysDic(String id) {
        sysDicDao.deleteSysDic(id);
    }

    public void insertSysDicMapping(SysDic sysDic) {
        sysDicDao.insertSysDicMapping(sysDic);
    }

    public List<SysDic> checkDicMapping(SysDic sysDic) {
        return sysDicDao.checkDicMapping(sysDic);
    }

    public List<SysDic> checkName(SysDic sysDic) {
        return sysDicDao.checkName(sysDic);
    }

    public List<SysDic> checkCode(SysDic sysDic) {
        return sysDicDao.checkCode(sysDic);
    }

    public List<SysDic> sysDicName(SysDic sysDic) {
        return sysDicDao.sysDicName(sysDic);
    }

    public List<SysDic> sysDicCode(SysDic sysDic) {
        return sysDicDao.sysDicCode(sysDic);
    }

    public SysDic getSysDicMappingID(String id) {
        return sysDicDao.getSysDicMappingID(id);
    }

    public void updateSysDicMapping(SysDic sysDic) {
        sysDicDao.updateSysDicMapping(sysDic);
    }

    public void deleteSysDicMapping(String id) {
        sysDicDao.deleteSysDicMapping(id);
    }

    @Override
    public List<SysDic> semesterList(SysDic sysDic) {
        return sysDicDao.semesterList(sysDic);
    }
    @Override
    public String getDicName(String diccode, String code) {
        return sysDicDao.getDicName(diccode,code);
    }
}
