package com.goisan.educational.exam.dao;

import com.goisan.educational.exam.bean.TestPaperAnalysis;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface TestPaperAnalysisDao {

    List<BaseBean> getTestPaperAnalysisList(BaseBean baseBean);

    void saveTestPaperAnalysis(BaseBean baseBean);

    TestPaperAnalysis getTestPaperAnalysisById(String id);

    void updateTestPaperAnalysis(BaseBean baseBean);

    void delTestPaperAnalysis(String id);

}
