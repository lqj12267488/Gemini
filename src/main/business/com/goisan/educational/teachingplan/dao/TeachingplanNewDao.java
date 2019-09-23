package com.goisan.educational.teachingplan.dao;

import com.goisan.educational.teachingplan.bean.TeachingplanNew;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Files;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TeachingplanNewDao {

    List<TeachingplanNew> getTeachingplanNewList(TeachingplanNew teachingplanNew);

    void saveTeachingplanNew(BaseBean baseBean);

    BaseBean getTeachingplanNewById(String id);

    void updateTeachingplanNew(BaseBean baseBean);

    void delTeachingplanNew(String id);

    void changeTeachingplanNewStatus(@Param("id") String id, @Param("status") String status);

    void audit(TeachingplanNew teachingplanNew);

    List<Select2> getTimeTableSelect();

    List<Map<String, Object>> getCourseById(@Param("id") String id, @Param("personId") String personId);
    /**
     * 通过业务id 获取附件信息
     */
    Files getFilesByBusinessId(@Param("id") String id);
}
