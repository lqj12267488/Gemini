package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.DraftPaper;
import com.goisan.synergy.workflow.dao.DraftPaperDao;
import com.goisan.synergy.workflow.service.DraftPaperService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mcq on 2017/7/17.
 */
@Service
public class DraftPaperImpl implements DraftPaperService {
    @Resource
    private DraftPaperDao draftPaperDao;
    public List<DraftPaper> getDraftPaperList(DraftPaper draftPaper) {
        return draftPaperDao.getDraftPaperList(draftPaper);
    }

    public void insertDraftPaper(DraftPaper draftPaper) {
        draftPaperDao.insertDraftPaper(draftPaper);
    }

    public DraftPaper getDraftPaperById(String id) {
        return draftPaperDao.getDraftPaperById(id);
    }

    public void updateDraftPaperById(DraftPaper draftPaper) {
        draftPaperDao.updateDraftPaperById(draftPaper);
    }

    public void deleteDraftPaperById(String id) {
        draftPaperDao.deleteDraftPaperById(id);
    }

    public List<DraftPaper> getProcessList(DraftPaper draftPaper) {
        return draftPaperDao.getProcessList(draftPaper);
    }

    public List<DraftPaper> getCompleteList(DraftPaper draftPaper) {
        return draftPaperDao.getCompleteList(draftPaper);
    }

    public String getPersonNameById(String personId) {
        return draftPaperDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return draftPaperDao.getDeptNameById(deptId);
    }
}
