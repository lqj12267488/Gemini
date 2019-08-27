package com.goisan.personnel.training.service;

import com.goisan.personnel.training.bean.Training;
import com.goisan.personnel.training.bean.TrainingMember;
import com.goisan.system.bean.Tree;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TrainingService {
    //组织培训申请
    List<Training> getDepartmentTrainingList(Training departmentTraining);
    void saveDepartmentTraining(Training departmentTraining);
    Training getDepartmentTrainingById(String id);
    void updateDepartmentTraining(Training departmentTraining);
    void delDepartmentTraining(String id);


    //组织培训审核
    List<Training> getDepartmentAuditList(Training departmentTraining);
    //组织培训查询
    List<Training> getDepartmentSearchList(Training departmentTraining);

    //个人培训申请
    List<Training> getPersonalTrainingList(Training personalTraining);
    void savePersonalTraining(Training personalTraining);
    Training getPersonalTrainingById(String id);
    void updatePersonalTraining(Training personalTraining);
    void delPersonalTraining(String id);

    //个人培训审核
    List<Training> getPersonalAuditList(Training personalTraining);
    //个人培训查询
    List<Training> getPersonalSearchList(Training personalTraining);

    //团体培训申请
    List<Training> getGroupTrainingList(Training groupTraining);
    void saveGroupTraining(Training groupTraining);
    Training getGroupTrainingById(String id);
    void updateGroupTraining(Training groupTraining);
    void delGroupTraining(String id);
    //团体培训审核
    List<Training> getGroupAuditList(Training groupTraining);
    //团体培训查询
    List<Training> getGroupSearchList(Training groupTraining);
    //人员树形下拉选
    List<Tree> getEmpTreeByDeptId(String deptId,String id);
    //已选人员树形下拉选
    List<Training> getSelectedEmpByDeptId(String deptId);
    //参培教师列表数据
    List<TrainingMember> getReportMemberList(TrainingMember trainingMember);
    //保存参加培训人员
    void saveTrainingMember(TrainingMember trainingMember);
    //修改参加培训人员数量
    void updateTraining(Training training);
    //获取可参加培训人员数量
    String getTrainingOverPlusApplyNumber(String id);
    //删除参培教师
    void delReportTeacher(String memberId);

    void saveDepartmentReportTeacher(String ids,String id,String deptId);

    void saveGroupReportTeacher(String ids,String id,String deptId);

    List<Training> upGetDepartmentTrainingList(Training departmentTraining);

    List<Training> upGetGroupTrainingList(Training groupTraining);
}