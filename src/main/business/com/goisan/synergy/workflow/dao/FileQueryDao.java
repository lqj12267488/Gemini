package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.FileQuery;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/7/19.
 */
@Repository
public interface FileQueryDao {
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
