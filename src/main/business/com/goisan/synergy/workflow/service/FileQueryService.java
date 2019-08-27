package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.FileQuery;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by hanyu on 2017/7/19.
 */
public interface FileQueryService {
    List<FileQuery> getFileQueryList(FileQuery fileQuery);
    void insertFileQuery(FileQuery fileQuery);
    FileQuery getFileQueryById(String id);
    void updateFileQueryById(FileQuery fileQuery);
    void deleteFileQueryById(String id);
    List<AutoComplete> autoCompleteDept();
    List<AutoComplete> autoCompleteEmployee();
    List<FileQuery> getProcessList(FileQuery fileQuery);
    List<FileQuery> getCompleteList(FileQuery fileQuery);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
