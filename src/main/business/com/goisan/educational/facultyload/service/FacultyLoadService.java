package com.goisan.educational.facultyload.service;

import com.goisan.educational.facultyload.bean.FacultyLoad;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.Message;

import java.util.List;
import java.util.Map;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/11/15
 */
public interface FacultyLoadService {

    Message saveOrUpdateFacultyLoad(FacultyLoad facultyLoad);

    Message deleteFacultyLoadByIds(String ids);

    FacultyLoad getFacultyLoadById(String id);

    List<FacultyLoad> getFacultyLoadList(FacultyLoad facultyLoad);
}
