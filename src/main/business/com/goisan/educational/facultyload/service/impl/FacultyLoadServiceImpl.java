package com.goisan.educational.facultyload.service.impl;

import com.goisan.educational.facultyload.bean.FacultyLoad;
import com.goisan.educational.facultyload.dao.FacultyLoadDao;
import com.goisan.educational.facultyload.service.FacultyLoadService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/11/15
 */
@Service
public class FacultyLoadServiceImpl implements FacultyLoadService {

    /**
     * @function: 查询教学工作量数据
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: baseBean
     */
    @Override
    public List<FacultyLoad> getFacultyLoadList(FacultyLoad facultyLoad) {

        try {

            if (facultyLoad != null) {

                return facultyLoadDao.getFacultyLoadList(facultyLoad);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 通过Id获取教学工作量实体类
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: id
     */
    @Override
    public FacultyLoad getFacultyLoadById(String id) {

        try {

            if (id != null && !"".equals(id)) {

                return facultyLoadDao.getFacultyLoadById(id);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 添加或编辑教学工作量
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: FacultyLoad
     */
    @Override
    public Message saveOrUpdateFacultyLoad(FacultyLoad facultyLoad) {
        try {
            if (facultyLoad != null) {
                if (facultyLoad.getId() != null && !"".equals(facultyLoad.getId())) {
                    CommonUtil.update(facultyLoad);
                    if (facultyLoadDao.updateFacultyLoad(facultyLoad) > 0) {
                        return new Message(1, "修改成功", null);
                    }
                } else {
                    String term = facultyLoad.getTerm();
                    String teacherId = facultyLoad.getTeacherId();
                    int skjh = facultyLoadDao.getSkjhSum(teacherId, term);
                    if (skjh == 0) {
                        return new Message(2, "请先维护授课计划、教案！", null);
                    }
                    int jxjh = facultyLoadDao.getJxjhSum(teacherId, term);
                    if (jxjh == 0) {
                        return new Message(2, "请先维护教学计划！", null);
                    }
                    int sj = facultyLoadDao.getSjSum(teacherId, term);
                    if (sj == 0) {
                        return new Message(2, "请先完成试卷分析！", null);
                    }
                    List<Map<String, Object>> cjs = facultyLoadDao.getCJSum(teacherId);
                    if (cjs.size() <= 0) {
                        return new Message(2, "请先录入成绩！", null);
                    }
                    for (Map<String, Object> cj : cjs) {
                        if (!"2".equals(cj.get("status"))) {
                            return new Message(1, "请先录入成绩！", null);
                        }
                    }
                    List<Integer> pjs = facultyLoadDao.getPjSum(teacherId);
                    for (Integer pj : pjs) {
                        if (pj != 100) {
                            return new Message(1, "请先完成评教！", null);
                        }
                    }
                    facultyLoad.setId(CommonUtil.getUUID());
                    CommonUtil.save(facultyLoad);
                    if (facultyLoadDao.insertFacultyLoad(facultyLoad) > 0) {
                        return new Message(1, "添加成功", null);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * @function: 根据Id删除教学工作量实体类
     * @author: ZhangHao
     * @date: 2018/10/14
     * @param: id
     */
    @Override
    public Message deleteFacultyLoadByIds(String ids) {

        try {

            if (ids != null && !"".equals(ids)) {

                if (facultyLoadDao.deleteFacultyLoadByIds(ids) > 0) {

                    return new Message(1, "删除成功", null);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    @Autowired
    private FacultyLoadDao facultyLoadDao;
}
