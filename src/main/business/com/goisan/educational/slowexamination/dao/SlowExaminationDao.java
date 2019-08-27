package com.goisan.educational.slowexamination.dao;


import com.goisan.educational.slowexamination.bean.SlowExamination;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Select2;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SlowExaminationDao {
  
    List<SlowExamination> getSlowExaminationList(SlowExamination slowExamination);

    String getPersonNameById(String personId);

    String getDeptNameById(String defaultDept);

    SlowExamination getSlowExaminationById(String id);

    void insertSlowExamination(SlowExamination slowExamination);

    void updateSlowExaminationById(SlowExamination slowExamination);

    void deleteSlowExaminationById(String id);

    List<SlowExamination> slowExaminationProcessAction(SlowExamination slowExamination);

    List<SlowExamination> slowExaminationCompleteAction(SlowExamination slowExamination);

    List<AutoComplete> selectDept();

    List<AutoComplete> selectPerson();

    List checkCode(SlowExamination slowExamination);

    List checkName(SlowExamination slowExamination);

    String getClassNameById(String personId);

    String getMajorCodeById(String personId);

    String getDeptIdById(String personId);

    String getClassIdById(String personId);

    List<Select2> getCourseSelect(SlowExamination slowExamination);
}
