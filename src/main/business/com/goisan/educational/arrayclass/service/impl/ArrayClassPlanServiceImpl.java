package com.goisan.educational.arrayclass.service.impl;

import com.goisan.educational.arrayclass.bean.ArrayClass;
import com.goisan.educational.arrayclass.bean.ArrayClassTeacherCourse;
import com.goisan.educational.arrayclass.bean.ArrayclassArray;
import com.goisan.educational.arrayclass.bean.ArrayclassResultClass;
import com.goisan.educational.arrayclass.dao.ArrayClassPlanDao;
import com.goisan.educational.arrayclass.service.ArrayClassPlanService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Service
public class ArrayClassPlanServiceImpl implements ArrayClassPlanService {
    @Resource
    private ArrayClassPlanDao arrayClassPlanDao;

    public List<BaseBean> getArrayclassArrayList(BaseBean baseBean) {
        return arrayClassPlanDao.getArrayclassArrayList(baseBean);
    }

    public void saveArrayclassArray(BaseBean baseBean) {
        arrayClassPlanDao.saveArrayclassArray(baseBean);
    }

    public BaseBean getArrayclassArrayById(String id) {
        return arrayClassPlanDao.getArrayclassArrayById(id);
    }

    public void updateArrayclassArray(BaseBean baseBean) {
        arrayClassPlanDao.updateArrayclassArray(baseBean);
    }

    public void delArrayclassArray(String id) {
        arrayClassPlanDao.delArrayclassArray(id);
    }

    public List<ArrayclassResultClass> getResultClassListById(String arrayclassId) {
        return arrayClassPlanDao.getResultClassListById(arrayclassId);
    }

    public List<ArrayclassArray> getArrayclassArrayListByArrayclassId(String arrayclassId) {
        return arrayClassPlanDao.getArrayclassArrayListByArrayclassId(arrayclassId);
    }

    public List<ArrayClassTeacherCourse> getArrayClassTeacherCoursesByArrayclassId(String arrayclassId) {
        return arrayClassPlanDao.getArrayClassTeacherCoursesByArrayclassId(arrayclassId);
    }

    public ArrayClass getArrayClassById(String arrayclassId) {
        return arrayClassPlanDao.getArrayClassById(arrayclassId);
    }

    public void savaArrayClassResultClass(Map<String, ArrayclassResultClass>[] rc) {
        for (Map<String, ArrayclassResultClass> map : rc) {
            if (map != null) {
                Collection<ArrayclassResultClass> resultClasses = map.values();
                for (ArrayclassResultClass arrayclassResultClass : resultClasses) {
                    if (arrayclassResultClass.getId() == null) {
                        arrayclassResultClass.setId(CommonUtil.getUUID());
                        arrayClassPlanDao.savaArrayClassResultClass(arrayclassResultClass);
                    }
                }
            }
        }
    }

    public void updateArrayclass(String arrayclassId) {
        arrayClassPlanDao.updateArrayclass(arrayclassId);
    }
}
