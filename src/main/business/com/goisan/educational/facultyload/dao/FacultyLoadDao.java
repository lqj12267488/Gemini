package com.goisan.educational.facultyload.dao;

import com.goisan.educational.facultyload.bean.FacultyLoad;
import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/11/15
 */
@Repository
public interface FacultyLoadDao {

    int insertFacultyLoad(FacultyLoad facultyLoad);

    int updateFacultyLoad(FacultyLoad facultyLoad);

    int deleteFacultyLoadByIds(String ids);

    FacultyLoad getFacultyLoadById(String id);

    List<FacultyLoad> getFacultyLoadList(FacultyLoad facultyLoad);

    int getSkjhSum(@Param("teacherId") String teacherId, @Param("term") String term);

    int getSjSum(@Param("teacherId") String teacherId, @Param("term") String term);

    List<Map<String, Object>> getCJSum(@Param("teacherId") String teacherId);

    List<Integer> getPjSum(@Param("teacherId") String teacherId);

    int getJxjhSum(@Param("teacherId") String teacherId, @Param("term") String term);
}
