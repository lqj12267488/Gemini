package com.goisan.educational.teachingresult.service.impl;

import com.goisan.educational.teachingresult.bean.*;
import com.goisan.educational.teachingresult.dao.TeacherResultDao;
import com.goisan.educational.teachingresult.service.TeacherResultService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
@Service
public class TeacherResultServiceImpl implements TeacherResultService {
    @Resource
    private TeacherResultDao teacherResultDao;

    public List<TeachingResult> getTeacherResultList(TeachingResult teachingResult) {
        return teacherResultDao.getTeacherResultList(teachingResult);
    }

    public void insertTeachingResult(TeachingResult teachingResult) {
        teacherResultDao.insertTeachingResult(teachingResult);
    }

    public TeachingResult getTeachingResultById(String id) {
        return teacherResultDao.getTeachingResultById(id);
    }

    public void updateTeachingResult(TeachingResult teachingResult) {
        teacherResultDao.updateTeachingResult(teachingResult);
    }

    public void deleteTeachingResultById(String id) {
        teacherResultDao.deleteTeachingResultById(id);
    }

    public List<AutoComplete> selectPerson() {
        return teacherResultDao.selectPerson();
    }

    public List<AutoComplete> selectDept() {
        return teacherResultDao.selectDept();
    }

//教科研成果管理（项目）
    public List<TeachingResultProject> getTeachingResultProjectList(TeachingResultProject teachingResultProject) {
        return teacherResultDao.getTeachingResultProjectList(teachingResultProject);
    }

    public void insertTeachingResultProject(TeachingResultProject teachingResultProject) {
        teacherResultDao.insertTeachingResultProject(teachingResultProject);
    }

    public TeachingResultProject getTeachingResultProjectById(String id) {
        return teacherResultDao.getTeachingResultProjectById(id);
    }

    public void updateTeachingResultProject(TeachingResultProject teachingResultProject) {
        teacherResultDao.updateTeachingResultProject(teachingResultProject);
    }

    public void deleteTeachingResultProject(String id) {
        teacherResultDao.deleteTeachingResultProject(id);
    }

//教科研成果管理（国家标准或行业标准）
    public List<TeachingResultStandard> getTeachingResultStandardList(TeachingResultStandard teachingResultStandard) {
        return teacherResultDao.getTeachingResultStandardList(teachingResultStandard);
    }

    public void insertTeachingResultStandard(TeachingResultStandard teachingResultStandard) {
        teacherResultDao.insertTeachingResultStandard(teachingResultStandard);
    }

    public TeachingResultStandard getTeachingResultStandardById(String id) {
        return teacherResultDao.getTeachingResultStandardById(id);
    }

    public void updateTeachingResultStandard(TeachingResultStandard teachingResultStandard) {
        teacherResultDao.updateTeachingResultStandard(teachingResultStandard);
    }

    public void deleteTeachingResultStandard(String id) {
        teacherResultDao.deleteTeachingResultStandard(id);
    }

//教科研成果管理（国家医药证书）
    public List<TeachingResultMedicine> getTeachingResultMedicineList(TeachingResultMedicine teachingResultMedicine) {
        return teacherResultDao.getTeachingResultMedicineList(teachingResultMedicine);
    }

    public void insertTeachingResultMedicine(TeachingResultMedicine teachingResultMedicine) {
        teacherResultDao.insertTeachingResultMedicine(teachingResultMedicine);
    }

    public TeachingResultMedicine getTeachingResultMedicineById(String id) {
        return teacherResultDao.getTeachingResultMedicineById(id);
    }

    public void updateTeachingResultMedicine(TeachingResultMedicine teachingResultMedicine) {
        teacherResultDao.updateTeachingResultMedicine(teachingResultMedicine);
    }

    public void deleteTeachingResultMedicine(String id) {
        teacherResultDao.deleteTeachingResultMedicine(id);
    }

//教科研成果管理（论文）
    public List<TeachingResultPaper> getTeachingResultPaperList(TeachingResultPaper teachingResultPaper) {
        return teacherResultDao.getTeachingResultPaperList(teachingResultPaper);
    }

    public void insertTeachingResultPaper(TeachingResultPaper teachingResultPaper) {
        teacherResultDao.insertTeachingResultPaper(teachingResultPaper);
    }

    public TeachingResultPaper getTeachingResultPaperById(String id) {
        return teacherResultDao.getTeachingResultPaperById(id);
    }

    public void updateTeachingResultPaper(TeachingResultPaper teachingResultPaper) {
        teacherResultDao.updateTeachingResultPaper(teachingResultPaper);
    }

    public void deleteTeachingResultPaper(String id) {
        teacherResultDao.deleteTeachingResultPaper(id);

    }
//教科研成果管理（著作）
    public List<TeachingResultWriting> getTeachingResultWritingList(TeachingResultWriting teachingResultWriting) {
        return teacherResultDao.getTeachingResultWritingList(teachingResultWriting);
    }

    public void insertTeachingResultWriting(TeachingResultWriting teachingResultWriting) {
        teacherResultDao.insertTeachingResultWriting(teachingResultWriting);
    }

    public TeachingResultWriting getTeachingResultWritingById(String id) {
        return teacherResultDao.getTeachingResultWritingById(id);
    }

    public void updateTeachingResultWriting(TeachingResultWriting teachingResultWriting) {
        teacherResultDao.updateTeachingResultWriting(teachingResultWriting);
    }

    public void deleteTeachingResultWriting(String id) {
        teacherResultDao.deleteTeachingResultWriting(id);
    }
//教科研成果管理（文艺作品）
    public List<TeachingResultArt> getTeachingResultArtList(TeachingResultArt teachingResultArt) {
        return teacherResultDao.getTeachingResultArtList(teachingResultArt);
    }

    public void insertTeachingResultArt(TeachingResultArt teachingResultArt) {
        teacherResultDao.insertTeachingResultArt(teachingResultArt);
    }

    public TeachingResultArt getTeachingResultArtById(String id) {
        return teacherResultDao.getTeachingResultArtById(id);
    }

    public void updateTeachingResultArt(TeachingResultArt teachingResultArt) {
        teacherResultDao.updateTeachingResultArt(teachingResultArt);
    }

    public void deleteTeachingResultArt(String id) {
        teacherResultDao.deleteTeachingResultArt(id);
    }
//教科研成果管理（指导学生参加竞赛获奖）
    public List<TeachingResultGuide> getTeachingResultGuideList(TeachingResultGuide teachingResultGuide) {
        return teacherResultDao.getTeachingResultGuideList(teachingResultGuide);
    }

    public void insertTeachingResultGuide(TeachingResultGuide teachingResultGuide) {
        teacherResultDao.insertTeachingResultGuide(teachingResultGuide);
    }

    public TeachingResultGuide getTeachingResultGuideById(String id) {
        return teacherResultDao.getTeachingResultGuideById(id);
    }

    public void updateTeachingResultGuide(TeachingResultGuide teachingResultGuide) {
        teacherResultDao.updateTeachingResultGuide(teachingResultGuide);
    }

    public void deleteTeachingResultGuide(String id) {
        teacherResultDao.deleteTeachingResultGuide(id);
    }
//教科研成果管理（专利或软件著作权）
    public List<TeachingResultPatent> getTeachingResultPatentList(TeachingResultPatent teachingResultPatent) {
        return teacherResultDao.getTeachingResultPatentList(teachingResultPatent);
    }

    public void insertTeachingResultPatent(TeachingResultPatent teachingResultPatent) {
        teacherResultDao.insertTeachingResultPatent(teachingResultPatent);
    }

    public TeachingResultPatent getTeachingResultPatentById(String id) {
        return teacherResultDao.getTeachingResultPatentById(id);
    }

    public void updateTeachingResultPatent(TeachingResultPatent teachingResultPatent) {
        teacherResultDao.updateTeachingResultPatent(teachingResultPatent);
    }

    public void deleteTeachingResultPatent(String id) {
        teacherResultDao.deleteTeachingResultPatent(id);
    }
//教科研成果管理（咨询报告或研究报告）
    public List<TeachingResultReport> getTeachingResultReportList(TeachingResultReport teachingResultReport) {
        return teacherResultDao.getTeachingResultReportList(teachingResultReport);
    }

    public void insertTeachingResultReport(TeachingResultReport teachingResultReport) {
        teacherResultDao.insertTeachingResultReport(teachingResultReport);
    }

    public TeachingResultReport getTeachingResultReportById(String id) {
        return teacherResultDao.getTeachingResultReportById(id);
    }

    public void updateTeachingResultReport(TeachingResultReport teachingResultReport) {
        teacherResultDao.updateTeachingResultReport(teachingResultReport);
    }

    public void deleteTeachingResultReport(String id) {
        teacherResultDao.deleteTeachingResultReport(id);
    }

    public List<TeachingResultProject> getCountList(TeachingResultProject teachingResultProject){return teacherResultDao.getCountList(teachingResultProject);}

//通过教科研成果id删除附件
    public void deleteFilesByBusinessId(String businessId){
        teacherResultDao.deleteFilesByBusinessId(businessId);
    }
}