package com.goisan.synergy.disInspection.service;

import com.goisan.synergy.disInspection.bean.DiAnswer;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/5
 */
public interface DiAnswerService {
    List<DiAnswer> getDiAnswerList (DiAnswer diAnswer);
    void insertDiAnswer  (DiAnswer diAnswer);
    DiAnswer getDiAnswerByRemarkId (DiAnswer diAnswer);
    List<DiAnswer> getDiReAnsList(DiAnswer diAnswer);
}
