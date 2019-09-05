package com.goisan.studentwork.graduatearchivesaddress.dao;

import com.goisan.studentwork.graduatearchivesaddress.bean.StuArcad;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/30
 */
@Repository
public interface StuArcadDao {
    List<StuArcad> getStuArcadList(StuArcad stuArcad);
    void insertStuArcad(StuArcad stuArcad);
    List<StuArcad> getStuByArcadId(String arcadId);
    StuArcad getStuArcadById(StuArcad stuArcad);
    List<StuArcad> checkStudent(StuArcad stuArcad);
    void delStuArcadByArcadId(StuArcad stuArcad);

    List<StuArcad>  getStuArcadByClass(StuArcad stuArcad);
    void updStuArcadById(StuArcad stuArcad);
}
