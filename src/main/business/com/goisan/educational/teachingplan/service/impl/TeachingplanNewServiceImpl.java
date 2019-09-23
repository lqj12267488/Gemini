package com.goisan.educational.teachingplan.service.impl;

import com.goisan.educational.teachingplan.bean.TeachingplanNew;
import com.goisan.educational.teachingplan.dao.TeachingplanNewDao;
import com.goisan.educational.teachingplan.service.TeachingplanNewService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Files;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class TeachingplanNewServiceImpl implements TeachingplanNewService {
    @Resource
    private TeachingplanNewDao teachingplanNewDao;

    public List<TeachingplanNew> getTeachingplanNewList(TeachingplanNew teachingplanNew) {
        return teachingplanNewDao.getTeachingplanNewList(teachingplanNew);
    }

    public void saveTeachingplanNew(BaseBean baseBean) {
        teachingplanNewDao.saveTeachingplanNew(baseBean);
    }

    public BaseBean getTeachingplanNewById(String id) {
        return teachingplanNewDao.getTeachingplanNewById(id);
    }

    public void updateTeachingplanNew(BaseBean baseBean) {
        teachingplanNewDao.updateTeachingplanNew(baseBean);
    }

    public void delTeachingplanNew(String id) {
        teachingplanNewDao.delTeachingplanNew(id);
    }

    @Override
    public void changeTeachingplanNewStatus(String id, String status) {
        teachingplanNewDao.changeTeachingplanNewStatus(id,status);
    }

    @Override
    public void audit(TeachingplanNew teachingplanNew) {
        teachingplanNewDao.audit(teachingplanNew);
    }

    @Override
    public List<Select2> getTimeTableSelect() {
        return teachingplanNewDao.getTimeTableSelect();
    }

    @Override
    public List<Map<String, Object>> getCourseById(String id, String personId) {
        return teachingplanNewDao.getCourseById(id,personId);
    }

    public Files getFilesByBusinessId(@Param("id") String id){
        return teachingplanNewDao.getFilesByBusinessId(id);
    }
}
