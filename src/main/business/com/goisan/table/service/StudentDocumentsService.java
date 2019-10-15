package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.StudentDocuments;

import java.util.List;

public interface StudentDocumentsService {

    List<BaseBean> getStudentDocumentsList(BaseBean baseBean);

    void saveStudentDocuments(BaseBean baseBean);

    StudentDocuments getStudentDocumentsById(String id);

    void updateStudentDocuments(BaseBean baseBean);

    void delStudentDocuments(String id);

}