package com.goisan.synergy.disInspection.dao;

/**
 * Created  By hanjie ON 2019/9/4
 */

import com.goisan.synergy.disInspection.bean.DiRemark;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiRemarkDao {


    List<DiRemark> getDiRemarkList(DiRemark  diRemark);

    @Select("select * from T_BG_DIREMARK where REMARK_ID = #{str}")
    DiRemark getDiRemarkById(String str);


    void insertDiRemark(DiRemark diRemark);

    void updateArcadById(DiRemark diRemark);

    void delDiRemarkById(DiRemark diRemark);

}
