package com.goisan.educational.orderwork.service.impl;

import com.goisan.educational.orderwork.bean.OtherWorkload;
import com.goisan.educational.orderwork.dao.OtherWorkloadDao;
import com.goisan.educational.orderwork.service.OtherWorkloadService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OtherWorkloadServiceImpl implements OtherWorkloadService{
    @Resource
    private OtherWorkloadDao otherWorkloadDao;
    public List<OtherWorkload> otherWorkloadAction(OtherWorkload otherWorkload){
        return otherWorkloadDao.otherWorkloadAction(otherWorkload);
    }
    public void deleteOtherWorkloadById(String id){
        otherWorkloadDao.deleteOtherWorkloadById(id);
    }
    public OtherWorkload getOtherWorkloadById(String id){
        return otherWorkloadDao.getOtherWorkloadById(id);
    }
    public void updateOtherWorkloadById(OtherWorkload otherWorkload){
        otherWorkloadDao.updateOtherWorkloadById(otherWorkload);
    }
    public void insertOtherWorkload(OtherWorkload otherWorkload){
        otherWorkloadDao.insertOtherWorkload(otherWorkload);
    }
}
