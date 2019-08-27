package com.goisan.system.service;

import com.goisan.system.bean.SysDic;

import java.util.List;

public interface SysDicService {
    List<SysDic> sysDicInfo(SysDic sysDic);
    List<SysDic> sysDicMappingInfo(SysDic sysDic);
    void insertSysDic(SysDic sysDic);
    SysDic getSysDicID(String id);
    void updateSysDic(SysDic sysDic);
    void deleteSysDic(String id);
    void insertSysDicMapping(SysDic sysDic);
    List<SysDic> checkDicMapping(SysDic sysDic);
    List<SysDic> checkName(SysDic sysDic);
    List<SysDic> checkCode(SysDic sysDic);
    List<SysDic> sysDicName(SysDic sysDic);
    List<SysDic> sysDicCode(SysDic sysDic);
    SysDic getSysDicMappingID(String id);
    void updateSysDicMapping(SysDic sysDic);
    void deleteSysDicMapping(String id);
    List<SysDic> semesterList(SysDic sysDic);
    String getDicName(String diccode,String code);
}
