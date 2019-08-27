package com.goisan.practice.service;

import com.goisan.practice.bean.Insurance;
import com.goisan.practice.bean.SampleTable;

import java.util.List;

public interface SampleTableService {
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
