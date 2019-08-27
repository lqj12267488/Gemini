package com.goisan.educational.arrayclass.service;

import com.goisan.educational.arrayclass.bean.ArrayClass;
import com.goisan.educational.arrayclass.bean.ArrayClassTeacherCourse;
import com.goisan.educational.arrayclass.bean.ArrayclassArray;
import com.goisan.educational.arrayclass.bean.ArrayclassResultClass;
import com.goisan.system.bean.BaseBean;

import java.util.List;
import java.util.Map;

public interface ArrayClassPlanService {

    List<BaseBean> getArrayclassArrayList(BaseBean baseBean);

    void saveArrayclassArray(BaseBean baseBean);

    BaseBean getArrayclassArrayById(String id);

    void updateArrayclassArray(BaseBean baseBean);

    void delArrayclassArray(String id);

    List<ArrayclassResultClass> getResultClassListById(String arrayclassId);

    List<ArrayclassArray> getArrayclassArrayListByArrayclassId(String arrayclassId);

    List<ArrayClassTeacherCourse> getArrayClassTeacherCoursesByArrayclassId(String arrayclassId);

    ArrayClass getArrayClassById(String arrayclassId);

    void savaArrayClassResultClass(Map<String, ArrayclassResultClass>[] rc);

    void updateArrayclass(String arrayclassId);
}