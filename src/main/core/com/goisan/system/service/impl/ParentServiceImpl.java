package com.goisan.system.service.impl;

import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.educational.score.dao.ScoreImportDao;
import com.goisan.educational.teachingresult.bean.TeachingResult;
import com.goisan.system.bean.*;
import com.goisan.system.dao.CommonDao;
import com.goisan.system.dao.ParentDao;
import com.goisan.system.service.ParentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ParentServiceImpl implements ParentService {
    @Resource
    private ParentDao parentDao;
    @Resource
    private ScoreImportDao scoreImportDao;
    @Resource
    private CommonDao commonDao;

    public List<BaseBean> getParentList(BaseBean baseBean) {
        return parentDao.getParentList(baseBean);
    }

    public void saveParent(BaseBean baseBean) {
        parentDao.saveParent(baseBean);
    }

    public BaseBean getParentById(String id) {
        return parentDao.getParentById(id);
    }

    public void updateParent(BaseBean baseBean) {
        parentDao.updateParent(baseBean);
    }

    public void delParent(String id) {
        parentDao.delParent(id);
    }

    public String checkParentIdcard(String idcard) {
        return parentDao.checkParentIdcard(idcard);
    }

    public List<Tree> getParsonStudentTree(String roleId) {
        return parentDao.getParsonStudentTree(roleId);
    }

    public List<Tree> getSurveyParsonTree(String surveyId) {
        return parentDao.getSurveyParsonTree( surveyId);
    }

    public List<Tree> getSurveyTeacherTree(String surveyId){
        return parentDao.getSurveyTeacherTree(surveyId);
    }

    public List<Tree> getSurveyStudentTree(String surveyId){
        return parentDao.getSurveyStudentTree(surveyId);
    }

    public List<TeacherBean> getCourseTeacherList(List ids){
        return parentDao.getCourseTeacherList(ids);
    }

    public List<TeacherBean> getCourseListByTeacher(String teacherId){
        return parentDao.getCourseListByTeacher(teacherId);
    }

    public List<Map> getScoreExamCourseList(String studentId, List<Select2> className){
        ScoreImport scoreImports = new ScoreImport();
        scoreImports.setStudentId(studentId);
        List<Map> data = new ArrayList<Map>();

        TableDict tableDict = new TableDict();
        tableDict.setTableName(" t_jw_score_import ");
        for (Select2 classBean : className) {
            Map<String, Object> map = new HashMap<>();
            scoreImports.setClassId(classBean.getId());
//            List<ScoreImport> examList = scoreImportDao.getScoreExamList(scoreImports);
            tableDict.setId(" TERM_ID ");
            tableDict.setText(" FUNC_GET_DICVALUE(TERM_ID, 'XQ' ) ");
            tableDict.setWhere(" where  class_id ='"+classBean.getId()+"' group by TERM_ID ");
            // 学期列表
            List<Select2> examList = commonDao.getTableDict(tableDict);

            // 科目列表
            tableDict.setId(" course_id ");
            tableDict.setText(" FUNC_GET_TABLEVALUE(course_id,'t_jw_course','course_id','COURSE_NAME') ");
            tableDict.setWhere(" where  class_id ='"+classBean.getId()+"' group by course_id ");
//            List<ScoreImport> courseList = scoreImportDao.getScoreCourseList(scoreImports);
            List<Select2> courseList = commonDao.getTableDict(tableDict);
            map.put("classBean",classBean);
            map.put("exam",examList);
            map.put("course",courseList);
            data.add(map);
        }
        return data;
    }

    @Override
    public void updateStudentId(Parent baseBean) {

        parentDao.updateStudentId(baseBean);
    }


}
