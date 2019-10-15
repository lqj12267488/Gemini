package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.StudentDocuments;

import java.util.List;

public interface StudentDocumentsDao {

    List<BaseBean> getStudentDocumentsList(BaseBean baseBean);

    void saveStudentDocuments(BaseBean baseBean);

    StudentDocuments getStudentDocumentsById(String id);

    void updateStudentDocuments(BaseBean baseBean);

    void delStudentDocuments(String id);

}
