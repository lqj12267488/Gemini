package com.goisan.educational.teachingresult.dao;

import com.goisan.educational.teachingresult.bean.*;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/7/13 0013.
 */
public interface TeacherResultDao {
    List<TeachingResult> getTeacherResultList(TeachingResult teachingResult);

    void insertTeachingResult(TeachingResult teachingResult);

    TeachingResult getTeachingResultById(String id);

    void updateTeachingResult(TeachingResult teachingResult);

    void deleteTeachingResultById(String id);

    List<AutoComplete> selectPerson();

    List<AutoComplete> selectDept();

//教科研成果管理（项目）
    List<TeachingResultProject> getTeachingResultProjectList(TeachingResultProject teachingResultProject);

    void insertTeachingResultProject(TeachingResultProject teachingResultProject);

    TeachingResultProject getTeachingResultProjectById(String id);

    void updateTeachingResultProject(TeachingResultProject teachingResultProject);

    void deleteTeachingResultProject(String id);

//教科研成果管理（国家标准或行业标准）
    List<TeachingResultStandard> getTeachingResultStandardList(TeachingResultStandard teachingResultStandard);

    void insertTeachingResultStandard(TeachingResultStandard teachingResultStandard);

    TeachingResultStandard getTeachingResultStandardById(String id);

    void updateTeachingResultStandard(TeachingResultStandard teachingResultStandard);

    void deleteTeachingResultStandard(String id);

//教科研成果管理（国家医药证书）
    List<TeachingResultMedicine> getTeachingResultMedicineList(TeachingResultMedicine teachingResultMedicine);

    void insertTeachingResultMedicine(TeachingResultMedicine teachingResultMedicine);

    TeachingResultMedicine getTeachingResultMedicineById(String id);

    void updateTeachingResultMedicine(TeachingResultMedicine teachingResultMedicine);

    void deleteTeachingResultMedicine(String id);
//教科研成果管理（论文）
    List<TeachingResultPaper> getTeachingResultPaperList(TeachingResultPaper teachingResultPaper);

    void insertTeachingResultPaper(TeachingResultPaper teachingResultPaper);

    TeachingResultPaper getTeachingResultPaperById(String id);

    void updateTeachingResultPaper(TeachingResultPaper teachingResultPaper);

    void deleteTeachingResultPaper(String id);
//教科研成果管理（著作）
    List<TeachingResultWriting> getTeachingResultWritingList(TeachingResultWriting teachingResultWriting);

    void insertTeachingResultWriting(TeachingResultWriting teachingResultWriting);

    TeachingResultWriting getTeachingResultWritingById(String id);

    void updateTeachingResultWriting(TeachingResultWriting teachingResultWriting);

    void deleteTeachingResultWriting(String id);
//教科研成果管理（文艺作品）
    List<TeachingResultArt> getTeachingResultArtList(TeachingResultArt teachingResultArt);

    void insertTeachingResultArt(TeachingResultArt teachingResultArt);

    TeachingResultArt getTeachingResultArtById(String id);

    void updateTeachingResultArt(TeachingResultArt teachingResultArt);

    void deleteTeachingResultArt(String id);
//教科研成果管理（指导学生参加竞赛获奖）
    List<TeachingResultGuide> getTeachingResultGuideList(TeachingResultGuide teachingResultGuide);

    void insertTeachingResultGuide(TeachingResultGuide teachingResultGuide);

    TeachingResultGuide getTeachingResultGuideById(String id);

    void updateTeachingResultGuide(TeachingResultGuide teachingResultGuide);

    void deleteTeachingResultGuide(String id);
//教科研成果管理（专利或软件著作权）
    List<TeachingResultPatent> getTeachingResultPatentList(TeachingResultPatent teachingResultPatent);

    void insertTeachingResultPatent(TeachingResultPatent teachingResultPatent);

    TeachingResultPatent getTeachingResultPatentById(String id);

    void updateTeachingResultPatent(TeachingResultPatent teachingResultPatent);

    void deleteTeachingResultPatent(String id);
//教科研成果管理（咨询报告或研究报告）
    List<TeachingResultReport> getTeachingResultReportList(TeachingResultReport teachingResultReport);

    void insertTeachingResultReport(TeachingResultReport teachingResultReport);

    TeachingResultReport getTeachingResultReportById(String id);

    void updateTeachingResultReport(TeachingResultReport teachingResultReport);

    void deleteTeachingResultReport(String id);

    List<TeachingResultProject> getCountList(TeachingResultProject teachingResultProject);

//通过教科研成果id删除附件
    void deleteFilesByBusinessId(String businessId);

}
