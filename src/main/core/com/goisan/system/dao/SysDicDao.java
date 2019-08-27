package com.goisan.system.dao;

import com.goisan.system.bean.SysDic;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysDicDao {
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
    String getDicName(@Param("diccode") String diccode, @Param("code") String code);
    String getDicCode(@Param("diccode") String diccode, @Param("dicName") String dicName);
}
