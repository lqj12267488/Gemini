package com.goisan.table.service.impl;

import com.goisan.table.bean.StudentDocuments;
import com.goisan.table.dao.StudentDocumentsDao;
import com.goisan.table.service.StudentDocumentsService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentDocumentsServiceImpl implements StudentDocumentsService {

    @Resource
    private StudentDocumentsDao studentDocumentsDao;

    @Override
    public List<BaseBean> getStudentDocumentsList(BaseBean baseBean) {
        return studentDocumentsDao.getStudentDocumentsList(baseBean);
    }

    @Override
    public void saveStudentDocuments(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        studentDocumentsDao.saveStudentDocuments(baseBean);
    }

    @Override
    public StudentDocuments getStudentDocumentsById(String id) {
        return studentDocumentsDao.getStudentDocumentsById(id);
    }

    @Override
    public void updateStudentDocuments(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        studentDocumentsDao.updateStudentDocuments(baseBean);
    }

    @Override
    public void delStudentDocuments(String id) {
        studentDocumentsDao.delStudentDocuments(id);
    }
}
