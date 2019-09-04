package com.goisan.studentwork.graduatearchivesaddress.service;

import com.goisan.studentwork.graduatearchivesaddress.bean.StuArcad;
import com.goisan.system.tools.Message;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/30
 */
public interface StuArcadService {

    List<StuArcad> getStuArcadList(StuArcad stuArcad);
    Message insertStuArcad(StuArcad stuArcad);
    List<StuArcad> getStuByArcadId(String arcadId);
    Message updStuArcad(StuArcad stuArcad);
    List<StuArcad>  getStuArcadByClass(StuArcad stuArcad);
    StuArcad getStuArcadById(StuArcad stuArcad);
    void updQueryStuArcad(StuArcad stuArcad);
}
