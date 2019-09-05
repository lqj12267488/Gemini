package com.goisan.synergy.disInspection.service;

import com.goisan.synergy.disInspection.bean.DiRemark;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/4
 */
public interface DiRemarkService {

    List<DiRemark> getDiRemarkList(DiRemark  diRemark);
    DiRemark getDiRemarkById(String str);
    void insertDiRemark(DiRemark diRemark);
    void updateArcadById(DiRemark diRemark);
    void delDiRemarkById(DiRemark diRemark);
}
