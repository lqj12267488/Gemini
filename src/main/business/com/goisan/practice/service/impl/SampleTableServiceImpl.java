package com.goisan.practice.service.impl;

import com.goisan.practice.bean.Insurance;
import com.goisan.practice.bean.SampleTable;
import com.goisan.practice.dao.InsuranceDao;
import com.goisan.practice.dao.SampleTableDao;
import com.goisan.practice.service.InsuranceService;
import com.goisan.practice.service.SampleTableService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SampleTableServiceImpl implements SampleTableService {
    @Resource
    private SampleTableDao sampleTableDao;

    public List<SampleTable> getTableManagementList(SampleTable sampleTable){
        return sampleTableDao.getTableManagementList(sampleTable);
    }

    public void deleteSampleTableById(String id){
        sampleTableDao.deleteSampleTableById(id);
    }
//
//    public Insurance getInsuranceById(String id){
//        return insuranceDao.getInsuranceById(id);
//    }
//
    public void updateSampleTableById(SampleTable sampleTable){
        sampleTableDao.updateSampleTableById(sampleTable);
    }
//
    public void insertSampleTable(SampleTable sampleTable){
        sampleTableDao.insertSampleTable(sampleTable);
    }
//
    public SampleTable getSampleTableById(String id){ return sampleTableDao.getSampleTableById(id); }
}
