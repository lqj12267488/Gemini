package com.goisan.studentwork.maintenance.service;

import com.goisan.studentwork.maintenance.bean.MtType;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/2
 */
public interface MtTypeService {
    List<MtType> getMtTypeList(MtType mtType);
    MtType getMtTypeById(MtType mtType);
    void insertMtType(MtType mtType);
    void updateMtTypeById(MtType mtType);
    void delMtTypeById(MtType mtType);

}
