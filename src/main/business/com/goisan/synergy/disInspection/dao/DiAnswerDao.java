package com.goisan.synergy.disInspection.dao;

import com.goisan.synergy.disInspection.bean.DiAnswer;
import com.goisan.synergy.disInspection.bean.DiRemark;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/5
 */
@Repository
public interface DiAnswerDao {
    List<DiAnswer> getDiAnswerList (DiAnswer diAnswer);
    void insertDiAnswer  (DiAnswer diAnswer);
    DiAnswer getDiAnswerByRemarkId (DiAnswer diAnswer);
    List<DiAnswer> getDiReAnsList(DiAnswer diAnswer);
    void delDiAnswerByRemarkId(DiRemark diRemark);
}
