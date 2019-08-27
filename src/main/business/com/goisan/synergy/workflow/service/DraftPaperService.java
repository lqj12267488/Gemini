package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.DraftPaper;

import java.util.List;

/**
 * Created by znw on 2017/7/17.
 */
public interface DraftPaperService {
    List<DraftPaper> getDraftPaperList(DraftPaper  draftPaper);
    void insertDraftPaper(DraftPaper draftPaper);
    DraftPaper getDraftPaperById(String id);
    void updateDraftPaperById(DraftPaper draftPaper);
    void deleteDraftPaperById(String id);
    List<DraftPaper> getProcessList(DraftPaper draftPaper);
    List<DraftPaper> getCompleteList(DraftPaper draftPaper);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);

}
