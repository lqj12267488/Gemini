package com.goisan.educational.exam.service.impl;

import com.goisan.educational.exam.bean.TestPaperAnalysis;
import com.goisan.educational.exam.dao.TestPaperAnalysisDao;
import com.goisan.educational.exam.service.TestPaperAnalysisService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TestPaperAnalysisServiceImpl implements TestPaperAnalysisService {
@Resource
private TestPaperAnalysisDao testPaperAnalysisDao;

    public List<BaseBean> getTestPaperAnalysisList(BaseBean baseBean) {
        return testPaperAnalysisDao.getTestPaperAnalysisList(baseBean);
    }

    public void saveTestPaperAnalysis(BaseBean baseBean) {
        testPaperAnalysisDao.saveTestPaperAnalysis(baseBean);
    }

    public TestPaperAnalysis getTestPaperAnalysisById(String id) {
        return testPaperAnalysisDao.getTestPaperAnalysisById(id);
    }

    public void updateTestPaperAnalysis(BaseBean baseBean) {
        testPaperAnalysisDao.updateTestPaperAnalysis(baseBean);
    }

    public void delTestPaperAnalysis(String id) {
        testPaperAnalysisDao.delTestPaperAnalysis(id);
    }
}
