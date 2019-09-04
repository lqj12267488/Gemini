package com.goisan.studentwork.maintenance.dao;

import com.goisan.studentwork.maintenance.bean.MtType;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/2
 */
@Repository
public interface MtTypeDao {
    List<MtType> getMtTypeList(MtType mtType);
    MtType getMtTypeById(MtType mtType);
    void insertMtType(MtType mtType);
    void updateMtTypeById(MtType mtType);
    void delMtTypeById(MtType mtType);


}
