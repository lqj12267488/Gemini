package com.goisan.practice.dao;

import com.goisan.practice.bean.Insurance;
import com.goisan.practice.bean.SampleTable;

import javax.annotation.Resource;
import java.util.List;

@Resource
public interface SampleTableDao {

    List<SampleTable> getTableManagementList(SampleTable sampleTable);

    void deleteSampleTableById(String id);
//
//    Insurance getInsuranceById(String id);
//
    void updateSampleTableById(SampleTable sampleTable);
//
    void insertSampleTable(SampleTable sampleTable);
//
    SampleTable getSampleTableById(String id);
}
