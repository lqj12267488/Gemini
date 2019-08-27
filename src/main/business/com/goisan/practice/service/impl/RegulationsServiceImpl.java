package com.goisan.practice.service.impl;

import com.goisan.practice.bean.Regulations;
import com.goisan.practice.dao.RegulationsDao;
import com.goisan.practice.service.RegulationsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RegulationsServiceImpl implements RegulationsService{
    @Resource
    private RegulationsDao regulationsDao;

    public List<Regulations> regulationsAction(Regulations regulations){
        return regulationsDao.regulationsAction(regulations);
    }

    public void deleteRegulationsById(String id){
        regulationsDao.deleteRegulationsById(id);
    }

    public Regulations getRegulationsById(String id){
        return regulationsDao.getRegulationsById(id);
    }

    public void updateRegulationsById(Regulations regulations){
        regulationsDao.updateRegulationsById(regulations);
    }

    public void insertRegulations(Regulations regulations){
        regulationsDao.insertRegulations(regulations);
    }
}
