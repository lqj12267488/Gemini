package com.goisan.personnel.training.service.impl;

import com.goisan.educational.exam.bean.Exam;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.personnel.training.bean.Training;
import com.goisan.personnel.training.bean.TrainingMember;
import com.goisan.personnel.training.dao.TrainingDao;
import com.goisan.personnel.training.service.TrainingService;
import com.goisan.synergy.workflow.bean.Funds;
import com.goisan.synergy.workflow.dao.FundsDao;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.Tree;
import com.goisan.system.dao.EmpDao;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.UpperMoney;
import com.goisan.task.bean.SysTask;
import com.goisan.task.dao.TaskDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TrainingServiceImpl implements TrainingService {
@Resource
private TrainingDao trainingDao;
@Resource
private ExamDao examDao;
@Resource
private TaskDao taskDao;
@Resource
private FundsDao fundsDao;


    public List<Training> getDepartmentTrainingList(Training departmentTraining) {
        return trainingDao.getDepartmentTrainingList(departmentTraining);
    }

    public void saveDepartmentTraining(Training departmentTraining) {
        trainingDao.saveDepartmentTraining(departmentTraining);
    }

    public Training getDepartmentTrainingById(String id) {
        return trainingDao.getDepartmentTrainingById(id);
    }

    public void updateDepartmentTraining(Training departmentTraining) {
        trainingDao.updateDepartmentTraining(departmentTraining);
    }

    public void delDepartmentTraining(String id) {
        trainingDao.delDepartmentTraining(id);
    }

    public List<Training> upGetDepartmentTrainingList(Training departmentTraining) {
        return trainingDao.upGetDepartmentTrainingList(departmentTraining);
    }

    public List<Training> upGetGroupTrainingList(Training groupTraining) {
        return trainingDao.upGetGroupTrainingList(groupTraining);
    }

    public List<Training> getDepartmentAuditList(Training departmentTraining) {
        return trainingDao.getDepartmentAuditList(departmentTraining);
    }

    public List<Training> getDepartmentSearchList(Training departmentTraining) {
        return trainingDao.getDepartmentSearchList(departmentTraining);
    }

    public List<Training> getPersonalTrainingList(Training personalTraining) {
        return trainingDao.getPersonalTrainingList(personalTraining);
    }

    public void savePersonalTraining(Training personalTraining) {
        trainingDao.savePersonalTraining(personalTraining);
    }

    public Training getPersonalTrainingById(String id) {
        return trainingDao.getPersonalTrainingById(id);
    }

    public void updatePersonalTraining(Training personalTraining) {
        trainingDao.updatePersonalTraining(personalTraining);
    }

    public void delPersonalTraining(String id) {
        trainingDao.delPersonalTraining(id);
    }

    public List<Training> getPersonalAuditList(Training personalTraining) {
        return trainingDao.getPersonalAuditList(personalTraining);
    }

    public List<Training> getPersonalSearchList(Training personalTraining) {
        return trainingDao.getPersonalSearchList(personalTraining);
    }

    public List<Training> getGroupTrainingList(Training groupTraining) {
        return trainingDao.getGroupTrainingList(groupTraining);
    }

    public void saveGroupTraining(Training groupTraining) {
        trainingDao.saveGroupTraining(groupTraining);
    }

    public Training getGroupTrainingById(String id) {
        return trainingDao.getGroupTrainingById(id);
    }

    public void updateGroupTraining(Training groupTraining) {
        trainingDao.updateGroupTraining(groupTraining);
    }

    public void delGroupTraining(String id) {
        trainingDao.delGroupTraining(id);
    }

    public List<Training> getGroupAuditList(Training groupTraining) {
        return trainingDao.getGroupAuditList(groupTraining);
    }

    public List<Training> getGroupSearchList(Training groupTraining) {
        return trainingDao.getGroupSearchList(groupTraining);
    }

    public List<Tree> getEmpTreeByDeptId(String deptId,String id) {
        return trainingDao.getEmpTreeByDeptId(deptId,id);
    }

    public List<Training> getSelectedEmpByDeptId(String deptId) {
        return trainingDao.getSelectedEmpByDeptId(deptId);
    }

    public List<TrainingMember> getReportMemberList(TrainingMember trainingMember) {
        return trainingDao.getReportMemberList(trainingMember);
    }

    public void saveTrainingMember(TrainingMember trainingMember) {
        trainingDao.saveTrainingMember(trainingMember);
    }

    public void updateTraining(Training training) {
        trainingDao.updateTraining(training);
    }

    public String getTrainingOverPlusApplyNumber(String id) {
        return trainingDao.getTrainingOverPlusApplyNumber(id);
    }

    public void delReportTeacher(String memberId) {
        trainingDao.delReportTeacher(memberId);
    }

    public void saveDepartmentReportTeacher(String ids, String id, String deptId) {
        String person_id="";
        int size=0;
        TrainingMember trainingMember=new TrainingMember();
        SysTask sysTask=new SysTask();
        Training training=new Training();
        Funds funds=new Funds();
        List<Emp> empList=examDao.chooseEmpList(deptId,ids);
        size=empList.size();
        trainingMember.setDeptId(deptId);
        training=trainingDao.getDepartmentTrainingById(id);
        if(empList.size()>0){
            for(int b=0;b<empList.size();b++){
                //插入参加培训人员表
                person_id=empList.get(b).getPersonId();
                trainingMember.setPersonId(person_id);
                trainingMember.setMemberId(CommonUtil.getUUID());
                trainingMember.setTrainingId(id);
                CommonUtil.save(trainingMember);
                trainingDao.saveTrainingMember(trainingMember);
                //插入待办任务表
                sysTask.setTaskId(CommonUtil.getUUID());
                sysTask.setDeptId(deptId);
                sysTask.setPersonId(person_id);
                sysTask.setTaskBusinessId(id);
                sysTask.setTaskFlag("0");
                sysTask.setTaskTable("T_SYS_TASK");
                sysTask.setTaskTime(training.getRequestDate());
                if("1".equals(training.getTrainingForm())){
                    sysTask.setTaskTitle(training.getTrainingProjectName()+"组织培训请款");
                }else if("3".equals(training.getTrainingForm())){
                    sysTask.setTaskTitle(training.getTrainingProjectName()+"团体培训请款");
                }

                sysTask.setTaskUrl("/task/auditTaskEdit");
                CommonUtil.save(sysTask);
                taskDao.saveSysTask(sysTask);
                //插入款项申请表
                funds.setId(CommonUtil.getUUID());
                funds.setRequestDept(deptId);
                funds.setManager(person_id);
                funds.setCreator(person_id);
                funds.setCreateDept(deptId);
                funds.setRequestDate(training.getRequestDate());
                if("1".equals(training.getTrainingForm())){
                    funds.setReason(training.getTrainingProjectName()+"组织培训请款");
                }else if("3".equals(training.getTrainingForm())){
                    funds.setReason(training.getTrainingProjectName()+"团体培训请款");
                }
                funds.setRequestFlag("0");
                funds.setAmount(training.getTrainingFee());
                funds.setAmountUpper(UpperMoney.change(Double.parseDouble(funds.getAmount())));
                funds.setRemark("无");
                fundsDao.insertFunds(funds);

            }

        }

        //更新信息管理表
        String number=training.getTrainingApplyNumber();
        if("0".equals(number)){
            training.setId(id);
            training.setTrainingApplyNumber(String.valueOf(size));
            trainingDao.updateTraining(training);
        }else{
            training.setId(id);
            String applyNumber=String.valueOf(Integer.parseInt(number)+Integer.parseInt(String.valueOf(size)));
            training.setTrainingApplyNumber(applyNumber);
            trainingDao.updateTraining(training);
        }

    }

    public void saveGroupReportTeacher(String ids, String id, String deptId) {
        String person_id="";
        int size=0;
        TrainingMember trainingMember=new TrainingMember();
        SysTask sysTask=new SysTask();
        Training training=new Training();
        Funds funds=new Funds();
        List<Emp> empList=examDao.chooseEmpList(deptId,ids);
        size=empList.size();
        trainingMember.setDeptId(deptId);
        training=trainingDao.getDepartmentTrainingById(id);
        if(empList.size()>0){
            for(int b=0;b<empList.size();b++){
                //插入参加培训人员表
                person_id=empList.get(b).getPersonId();
                trainingMember.setPersonId(person_id);
                trainingMember.setMemberId(CommonUtil.getUUID());
                trainingMember.setTrainingId(id);
                CommonUtil.save(trainingMember);
                trainingDao.saveTrainingMember(trainingMember);
                //插入待办任务表
                sysTask.setTaskId(CommonUtil.getUUID());
                sysTask.setDeptId(deptId);
                sysTask.setPersonId(person_id);
                sysTask.setTaskBusinessId(id);
                sysTask.setTaskFlag("0");
                sysTask.setTaskTable("T_SYS_TASK");
                sysTask.setTaskTime(training.getRequestDate());
                if("1".equals(training.getTrainingForm())){
                    sysTask.setTaskTitle(training.getTrainingProjectName()+"组织培训请款");
                }else if("3".equals(training.getTrainingForm())){
                    sysTask.setTaskTitle(training.getTrainingProjectName()+"团体培训请款");
                }

                sysTask.setTaskUrl("/task/auditTaskEdit");
                CommonUtil.save(sysTask);
                taskDao.saveSysTask(sysTask);
                //插入款项申请表
                funds.setId(CommonUtil.getUUID());
                funds.setRequestDept(deptId);
                funds.setManager(person_id);
                funds.setCreator(person_id);
                funds.setCreateDept(deptId);
                funds.setRequestDate(training.getRequestDate());
                if("1".equals(training.getTrainingForm())){
                    funds.setReason(training.getTrainingProjectName()+"组织培训请款");
                }else if("3".equals(training.getTrainingForm())){
                    funds.setReason(training.getTrainingProjectName()+"团体培训请款");
                }
                funds.setRequestFlag("0");
                funds.setAmount(training.getTrainingFee());
                funds.setAmountUpper(UpperMoney.change(Double.parseDouble(funds.getAmount())));
                funds.setRemark("无");
                fundsDao.insertFunds(funds);

            }

        }

        //更新信息管理表
        String number=training.getTrainingApplyNumber();
        if("0".equals(number)){
            training.setId(id);
            training.setTrainingApplyNumber(String.valueOf(size));
            trainingDao.updateTraining(training);
        }else{
            training.setId(id);
            String applyNumber=String.valueOf(Integer.parseInt(number)+Integer.parseInt(String.valueOf(size)));
            training.setTrainingApplyNumber(applyNumber);
            trainingDao.updateTraining(training);
        }


    }
}
