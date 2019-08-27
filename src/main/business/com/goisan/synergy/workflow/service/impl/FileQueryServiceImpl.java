package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.FileQuery;
import com.goisan.synergy.workflow.dao.FileQueryDao;
import com.goisan.synergy.workflow.service.FileQueryService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/7/19.
 */
@Service
public class FileQueryServiceImpl implements FileQueryService{
    @Resource
    private FileQueryDao fileQueryDao;
    public List<FileQuery> getFileQueryList(FileQuery fileQuery){ return fileQueryDao.getFileQueryList(fileQuery);}
    public void insertFileQuery(FileQuery fileQuery){ fileQueryDao.insertFileQuery(fileQuery);}
    public FileQuery getFileQueryById(String id){ return fileQueryDao.getFileQueryById(id);}
    public void updateFileQueryById(FileQuery fileQuery){ fileQueryDao.updateFileQueryById(fileQuery);}
    public void deleteFileQueryById(String id){ fileQueryDao.deleteFileQueryById(id);}
    public List<AutoComplete> autoCompleteDept(){ return fileQueryDao.autoCompleteDept(); }
    public List<AutoComplete> autoCompleteEmployee(){ return fileQueryDao.autoCompleteEmployee(); }
    public List<FileQuery> getProcessList(FileQuery fileQuery){ return fileQueryDao.getProcessList(fileQuery); }
    public List<FileQuery> getCompleteList(FileQuery fileQuery){ return fileQueryDao.getCompleteList(fileQuery); }
    public String getPersonNameById(String personId){ return fileQueryDao.getPersonNameById(personId); }
    public String getDeptNameById(String deptId){ return fileQueryDao.getDeptNameById(deptId); }
}
