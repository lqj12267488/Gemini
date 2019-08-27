package com.goisan.evaluation.service.impl;

import com.goisan.evaluation.bean.*;
import com.goisan.evaluation.dao.EvaluationDao;
import com.goisan.evaluation.service.EvaluationService;
import com.goisan.system.bean.EchartsMenu;
import com.goisan.system.bean.Index;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.dao.EchartsMenuDao;
import com.goisan.system.tools.CommonUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.regex.Pattern;

/**
 * Created by Admin on 2017/5/23.
 */
@Service
public class EvaluationServiceImpl implements EvaluationService {
    @Resource
    private EvaluationDao evaluationDao;
    @Resource
    private EchartsMenuDao echartsMenuDao;

    public void saveGroup(Group group) {
        evaluationDao.saveGroup(group);
    }

    public void deleteGroup(String id) {
        evaluationDao.deleteGroup(id);
    }

    public List getGroupList(Group group) {
        return evaluationDao.getGroupList(group);
    }

    public List<EvaluationMembers> getMembersByGroupId(String id, String memberType) {
        return evaluationDao.getMembersByGroupId(id, memberType);
    }

    public void saveMember(EvaluationMembers evaluationMembers) {
        evaluationDao.saveMember(evaluationMembers);
    }

    public void deleteMemberByGroupId(String groupId, String memberType) {
        evaluationDao.deleteMemberByGroupId(groupId, memberType);
    }

    public void updateGroupMembersNum(String groupId) {
        evaluationDao.updateGroupMembersNum(groupId);
    }

    public void savePlan(EvaluationPlan evaluationPlan) {
        evaluationDao.savePlan(evaluationPlan);
    }

    public List getPlanList(EvaluationPlan plan) {
        return evaluationDao.getPlanList(plan);
    }

    public EvaluationPlan getPlan(String id) {
        return evaluationDao.getPlan(id);
    }

    public void upadtePlan(EvaluationPlan evaluationPlan) {
        evaluationDao.upadtePlan(evaluationPlan);
    }

    public void deletePlan(String id) {
        evaluationDao.deletePlan(id);
    }

    public void deleteIndexByPlanid(String id) {
        evaluationDao.deleteIndexByPlanid(id);
    }

    public List<Tree> getIndexByPlanId(String id) {
        return evaluationDao.getIndexByPlanId(id);
    }

    public Integer getIndexScoreTotalByParentIndexId(String parentIndexId, String indexId) {
        return evaluationDao.getIndexScoreTotalByParentIndexId(parentIndexId,indexId);
    }

    public Integer getIndexScoreByIndexId(String parentIndexId) {
        return evaluationDao.getIndexScoreByIndexId(parentIndexId);
    }

    public Integer getPlanScoreByPlanId(String planId) {
        return evaluationDao.getPlanScoreByPlanId(planId);
    }

    public void deleteIndex(String id) {
        evaluationDao.deleteIndex(id);
    }

    public void saveIndex(Index index) {
        evaluationDao.saveIndex(index);
    }

    public Index getIndexById(String id) {
        return evaluationDao.getIndexById(id);
    }

    public void updateIndex(Index index) {
        evaluationDao.updateIndex(index);
    }

    public List<EvaluationTask> getTasks(EvaluationTask task) {
        return evaluationDao.getTasks(task);
    }

    public EvaluationTask getTask(String id) {
        return evaluationDao.getTask(id);
    }

    public void saveTask(EvaluationTask task) {
        evaluationDao.saveTask(task);
    }

    public void updateTask(EvaluationTask task) {
        evaluationDao.updateTask(task);
    }

    public void delTask(String id) {
        evaluationDao.delTask(id);
    }

    public List<Select2> getSelectPlan(EvaluationPlan plan) {
        return evaluationDao.getSelectPlan(plan);
    }

    public List<Select2> getSelectGroup(EvaluationPlan plan) {
        return evaluationDao.getSelectGroup(plan);
    }

    public List<EvaluationEmp> getEmpsByTaskId(String id) {
        return evaluationDao.getEmpsByTaskId(id);
    }

    public void deleteEmpsByTaskId(String taskId) {
        evaluationDao.deleteEmpsByTaskId(taskId);
    }

    public List<EvaluationMembers> getMembersByTaskId(String taskId) {
        return evaluationDao.getMembersByTaskId(taskId);
    }

    public void saveEmps(EvaluationEmp evaluationEmp) {
        evaluationDao.saveEmps(evaluationEmp);
    }

    public void savaEmpsMembers(EvaluationEmpsMenmbers members) {
        evaluationDao.savaEmpsMembers(members);
    }

    public void deleteEmpsMenmbersByTaskId(String taskId) {
        evaluationDao.deleteEmpsMenmbersByTaskId(taskId);
    }

    public void updateIndexLeafFlag(String parentIndexId, Integer type, Integer col) {
        evaluationDao.updateIndexLeafFlag(parentIndexId, type, col);
    }

    public Integer getLeafTotal(String parentIndexId) {
        return evaluationDao.getLeafTotal(parentIndexId);
    }

    public List<Index> getIndexByTaskId(String taskId) {
        return evaluationDao.getIndexByTaskId(taskId);
    }

    public List<EvaluationResult> getMonitorResults(String empId, String taskId, String membersId) {
        return evaluationDao.getMonitorResults(empId, taskId, membersId);
    }

    public List<EvaluationResult> listResultByPersonid(EvaluationResult evaluationResult) {
        return evaluationDao.listResultByPersonid(evaluationResult);
    }

    public List<EvaluationEmpsMenmbers> getlistTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        return evaluationDao.getlistTask(evaluationEmpsMenmbers);
    }

    public void updateEmpsMenmbers(EvaluationEmpsMenmbers eEMenmbers) {
        evaluationDao.updateEmpsMenmbers(eEMenmbers);
    }

    public List<Index> getlistIndex(String id) {
        return evaluationDao.getlistIndex(id);
    }

    public List<EvaluationResult> listResultByPersonid(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        return evaluationDao.listResultByPersonid(evaluationEmpsMenmbers);
    }

    public void insertResult(EvaluationResult evaluationResult) {
        evaluationDao.insertResult(evaluationResult);
    }

    public void insertResult(String taskId, String empPersonId, String empDeptId, String returnValue, String
            empName,String memberPersonId,String memberDeptId,String memberName) {
        EvaluationResult eResult = new EvaluationResult();
        eResult.setCreateDept(memberDeptId);
        eResult.setCreator(memberPersonId);
        eResult.setMemberDeptId(memberDeptId);
        eResult.setMemberPersonId(memberPersonId);
        eResult.setMemberName(memberName);
        eResult.setTaskId(taskId);
        eResult.setEmpPersonId(empPersonId);
        eResult.setEmpDeptId(empDeptId);
        eResult.setEmpName(empName);
        evaluationDao.delectResult(eResult);
        String[] result = returnValue.split("@@@@");
        for (int i = 0; i < result.length; i++) {
            String resultStr = result[i];
            String[] r = resultStr.split("##");
            String indexId = r[0];
            String score = r[1];
            if (r.length > 2) {
                String remark = r[2];
                if(null !=remark || !remark.equals("null"))
                    eResult.setRemark(remark);
                else
                    eResult.setRemark("");
            }else{
                eResult.setRemark("");
            }
            eResult.setIndexId(indexId);
            eResult.setScore(Double.parseDouble(score));
            eResult.setResultId(CommonUtil.getUUID());
            evaluationDao.insertResult(eResult);
        }
        EvaluationEmpsMenmbers eEMenmbers = new EvaluationEmpsMenmbers();
        eEMenmbers.setTaskId(taskId);
        eEMenmbers.setMemberPersonId(memberPersonId);
        eEMenmbers.setMemberDeptId(memberDeptId);
        eEMenmbers.setEmpDeptId(empDeptId);
        eEMenmbers.setEmpPersonId(empPersonId);
        evaluationDao.updateEvaluationEmpMenmber(eEMenmbers);

//        evaluationDao.insertResult(evaluationResult);
    }

    public void updateEvaluationEmpMenmber(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        evaluationDao.updateEvaluationEmpMenmber(evaluationEmpsMenmbers);
    }

    public Integer getMaxLevel(String taskId) {
        return evaluationDao.getMaxLevel(taskId);
    }

    public List<EvaluationTask> getMonitoerTask(EvaluationTask task) {
        return evaluationDao.getMonitoerTask(task);
    }

    public List<EvaluationTask> getMonitoerTaskBySelf(EvaluationTask task) {
        return evaluationDao.getMonitoerTaskBySelf(task);
    }

    public List<EvaluationEmp> getMonitoerEmpsByTaskId(EvaluationTask etask) {
        return evaluationDao.getMonitoerEmpsByTaskId(etask);
    }

    public List<Index> getIndexsByParentIndexId(String parentIndexId) {
        return evaluationDao.getIndexsByParentIndexId(parentIndexId);
    }

    public List<EvaluationEmpsMenmbers> getMembersByTaskIdAndEmpId(String id, String taskId) {
        return evaluationDao.getMembersByTaskIdAndEmpId(id, taskId);
    }

    public void invalid(EvaluationEmpsMenmbers menmber) {
        evaluationDao.invalid(menmber);
    }

    public EvaluationEmpsMenmbers getEmpsMenmbersById(String id) {
        return evaluationDao.getEmpsMenmbersById(id);
    }

    public Integer getIndexWeightsTotalByParentIndexId(String planId, String indexId) {
        return evaluationDao.getIndexWeightsTotalByParentIndexId(planId, indexId);
    }

    public Integer getIndexWeightsByIndexId(String parentIndexId) {
        return evaluationDao.getIndexWeightsByIndexId(parentIndexId);
    }

    public List<EvaluationResult> searchlistIndex(EvaluationEmpsMenmbers eEmpsMenmbers) {
        return evaluationDao.searchlistIndex(eEmpsMenmbers);
    }

    public List<EvaluationEmp> getMonitoerEmpsOrder(EvaluationTask etask) {
        return evaluationDao.getMonitoerEmpsOrder(etask);
    }

    public Integer calPlanScore(String id) {
        return evaluationDao.calPlanScore(id);
    }

    public void updatePlanTestFlag(String id, int testFlag) {
        evaluationDao.updatePlanTestFlag(id, testFlag);
    }

    public List<EvaluationTask> getTasksByPlanId(String id) {
        return evaluationDao.getTasksByPlanId(id);
    }

    public Integer calPlanWights(String id) {
        return evaluationDao.calPlanWights(id);
    }

    public void upadteGroup(Group group) {
        evaluationDao.upadteGroup(group);
    }

    public Group getGroup(String id) {
        return evaluationDao.getGroup(id);
    }

    public void delectResult(EvaluationResult eResult){
        evaluationDao.delectResult(eResult);
    }

    public List<Tree> getEmpsCheckByTask(String id){
        return evaluationDao.getEmpsCheckByTask(id);
    }
    public List<Tree> getClassStudentCheckByTask(String id){
        return evaluationDao.getClassStudentCheckByTask(id);
    }

    public void insertEmpsMembers(EvaluationTask task){
        evaluationDao.insertEmpsMembers(task);
    }

    public void delectEmpsMembers(String id){
        evaluationDao.delectEmpsMembers(id);
    }

    public List<EvaluationTask> getlistTaskNameApp(EvaluationEmpsMenmbers eEmpsMenmbers){
        return evaluationDao.getlistTaskNameApp(eEmpsMenmbers);
    }

    public List<EvaluationComplexTask> getEvaluationComplexTask(EvaluationComplexTask ecTask){
        return evaluationDao.getEvaluationComplexTask(ecTask);
    }

    public EvaluationComplexTask getEvaluationComplexTaskByid(String id){
        return evaluationDao.getEvaluationComplexTaskByid(id);
    }

    public void saveComplexTask(EvaluationComplexTask ecTask){
        evaluationDao.saveComplexTask(ecTask);
    }

    public void updateComplexTask(EvaluationComplexTask ecTask){
        evaluationDao.updateComplexTask(ecTask);
    }

    public void checkComplexTask(String id){
        evaluationDao.checkComplexTask(id);
    }

    public Integer getDetailWeights(String id){
        return evaluationDao.getDetailWeights(id);
    }

    public void seveComplexDetail(EvaluationComplexDetail ecDetail){
        evaluationDao.seveComplexDetail(ecDetail);
    }

    public void delComplexDetail(String id){
        evaluationDao.delComplexDetail(id);
    }

    public void delComplexTask(String id){
        evaluationDao.delComplexTask(id);
    }

    public void delComplexResult(String id){
        evaluationDao.delComplexResult(id);
    }

    public List<EvaluationComplexDetail> getEvaluationComplexDetail(String complexTaskId){
        return evaluationDao.getEvaluationComplexDetail(complexTaskId);
    }

    public EvaluationComplexDetail getEvaluationComplexDetailByid(String id){
        return evaluationDao.getEvaluationComplexDetailByid(id);
    }

    public void insertComplexResultBySingleTask(EvaluationComplexDetail ecDetail){
        evaluationDao.insertComplexResultBySingleTask(ecDetail);
    }

    public void insertComplexResultByTaskList(EvaluationComplexDetail ecDetail){
        evaluationDao.insertComplexResultByTaskList(ecDetail);
    }

    public List<EvaluationComplexResult> getEvaluationComplexResult(EvaluationComplexResult ecResult){
        return evaluationDao.getEvaluationComplexResult(ecResult);
    }

    public List<EvaluationComplexResult> getEvaluationComplexSumResult(EvaluationComplexDetail str){
        return evaluationDao.getEvaluationComplexSumResult(str);
    }

    public void deleteTaskByPlanId(String id) {
        evaluationDao.deleteTaskByPlanId(id);
    }

    public List<EvaluationTask> getMonitoerTaskByTeacherId(EvaluationTask task) {
        return evaluationDao.getMonitoerTaskByTeacherId(task);
    }

    @Override
    public List<EvaluationTask> getTasksByGroupId(String id) {
        return evaluationDao.getTasksByGroupId(id);
    }

    public Map<String, List<EvaluationEmp>> exportEvaluationResultList(String taskIds, String evaluationType){
        Map<String, List<EvaluationEmp>> map = new HashMap<String, List<EvaluationEmp>>();
        EvaluationTask etask = new EvaluationTask();
        etask.setEvaluationType(evaluationType);

        String[] taskIdlist = taskIds.split(",");
        for (int num = 0; num < taskIdlist.length; num++){
            String key = taskIdlist[num];
            if(key.equals(""))
                continue;
            etask.setTaskId(key);
            List<EvaluationEmp> evaluationList = evaluationDao.getEvaluationResultList(etask);
            if(null != evaluationList && evaluationList.size()>0) {
                String name = evaluationList.get(0).getName();
                map.put(name, evaluationList);
            }
        }
        return map;
    }

    public List<EvaluationEmp> getEvaluationResultList(EvaluationTask etask) {
        return evaluationDao.getEvaluationResultList(etask);
    }

    public List<Group> getEmpGroupList(Group group){
        return evaluationDao.getEmpGroupList(group);
    }

    public Group getEmpGroup(String id){
        return evaluationDao.getEmpGroup(id);
    }

    public void saveEmpGroup(Group group){
        evaluationDao.saveEmpGroup(group);
    }

    public List<EvaluationTask> getTasksByEmpGroupId(String id){
        return evaluationDao.getTasksByEmpGroupId(id);
    }

    public void deleteEmpGroup(String id){
        evaluationDao.deleteEmpGroup(id);
    }

    public void deleteMemberByEmpGroupId(String id){
        evaluationDao.deleteMemberByEmpGroupId(id);
    }

    public void updateEmpGroup(Group group){
        evaluationDao.updateEmpGroup(group);
    }

    public List<EvaluationGroupEmps> getEmpsTree(String groupId){
        return evaluationDao.getEmpsTree(groupId);
    }

    public List<EvaluationGroupEmps> getEmpsTreeByTaskId(String taskId){
        return evaluationDao.getEmpsTreeByTaskId(taskId);
    }

    public void saveGroupEmps(String ids, String groupId, String evaluationType){
        boolean b, c;
        EvaluationGroupEmps eGroupEmps = new EvaluationGroupEmps();
        eGroupEmps.setGroupId(groupId);
        eGroupEmps.setEvaluationType(evaluationType);
        CommonUtil.save(eGroupEmps);

        String[] tmp = ids.split(";");
        if (!"".equals(ids)) {
            for (String memberIdAndDeptId : tmp) {
                if(memberIdAndDeptId.split(",").length <=2)
                    continue;
                b = Pattern.matches("^\\d{15}|^\\d{17}([0-9]|X|x)$", memberIdAndDeptId.split(",")[0]);
                c = memberIdAndDeptId.split(",")[0].length() == 36;
                eGroupEmps.setEmpId(CommonUtil.getUUID());
                eGroupEmps.setPersonId(memberIdAndDeptId.split(",")[0]);
                if( ("0".equals(evaluationType) && c) ||("1".equals(evaluationType) && b))  {
                    eGroupEmps.setDeptId(memberIdAndDeptId.split(",")[1]);
                    eGroupEmps.setName(memberIdAndDeptId.split(",")[2]);
                    evaluationDao.insertGroupEmps(eGroupEmps);
                }
            }
        }
        evaluationDao.updateGroupEmpsNum(groupId);
    }

    public void deleteGroupEmps(String id){
        evaluationDao.deleteGroupEmps(id);
    }

    public void editCopyMemberGroup(String id){
        String groupId = CommonUtil.getUUID();
        String creator = CommonUtil.getPersonId();
        String createDept = CommonUtil.getDefaultDept();
        evaluationDao.copyMemberGroup(groupId, creator,createDept,id);
        evaluationDao.copyMembers(groupId, creator,createDept,id);

    }

    public void editCopyPlan(String id){
        String planId = CommonUtil.getUUID();
        String creator = CommonUtil.getPersonId();
        String createDept = CommonUtil.getDefaultDept();
        evaluationDao.copyPlan(planId, creator,createDept,id);

        List<Index> indesListFir = evaluationDao.getIndexsByParentIndexId(id);
        for(Index indexFir : indesListFir){
            String indexFId = CommonUtil.getUUID();
            evaluationDao.copyIndexById(planId,indexFId, planId ,indexFir.getIndexId(),creator,createDept);

            List<Index> indesListSec = evaluationDao.getIndexsByParentIndexId(indexFir.getIndexId());
            for(Index indexSec : indesListSec){
                String indexSId = CommonUtil.getUUID();
                evaluationDao.copyIndexById(planId,indexSId, indexFId ,indexSec.getIndexId(),creator,createDept);

                evaluationDao.copyIndexList(planId,indexSId,indexSec.getIndexId(),creator,createDept);
            }
        }

    }

    public void editCopyEmpGroup(String id){
        String groupId = CommonUtil.getUUID();
        String creator = CommonUtil.getPersonId();
        String createDept = CommonUtil.getDefaultDept();
        evaluationDao.copyEmpGroup(groupId, creator,createDept,id);
        evaluationDao.copyEmps(groupId, creator,createDept,id);

    }

    public void editCopyTask(String id){
        String taskId = CommonUtil.getUUID();
        String creator = CommonUtil.getPersonId();
        String createDept = CommonUtil.getDefaultDept();
        evaluationDao.copyTask(taskId, creator,createDept,id);
    }

    public Map<String, List> getMembersByTaskIDType(String id){
        Map<String, List> map = new HashMap<String, List>();
        List<Tree> empList = evaluationDao.getMembersByTaskIDEmp(id);
        List<Tree> leaderList = evaluationDao.getMembersByTaskIDLeader(id);
        List<Tree> teacherList = evaluationDao.getMembersByTaskIDTeacher(id);
        List<Tree> studentList = evaluationDao.getMembersByTaskIDStudent(id);
        List<Tree> peerList = evaluationDao.getMembersByTaskIDPeer(id);
        List<Tree> parentList = evaluationDao.getMembersByTaskIDParent(id);
        List<Tree> stu = evaluationDao.getMembersByTaskIDStu(id);
        map.put("tea",empList);
        map.put("leader",leaderList);
        map.put("teacher",teacherList);
        map.put("student",studentList);
        map.put("peer",peerList);
        map.put("parent",parentList);
        map.put("stu",stu);
        return map;
    }

    public void saveProportion(EvaluationTask task){
        evaluationDao.saveProportion(task);
    }

    public void setStartFlagByTaskId(String taskId,String startFlag){
        evaluationDao.updateEvaluationType(taskId , startFlag);
        evaluationDao.setStartFlagByTaskId(taskId,startFlag);
    }
    public  Map getcheckEmpsList(String complexTaskId, String evaluationType){
        EvaluationComplexDetail str = new EvaluationComplexDetail();
        str.setComplexTaskId(complexTaskId);
        str.setEvaluationType(evaluationType);
        // 所有被评分人
        List<EvaluationComplexResult> list = evaluationDao.getEvaluationComplexSumResult(str);
        List<Map> data = new ArrayList<Map>();
        // 所有评分子项
        List<EvaluationComplexDetail> details = evaluationDao.getEvaluationComplexDetail(complexTaskId);

        if( null ==list || list.size()==0 ){
            evaluationDao.delComplexResult(complexTaskId);
            List<EvaluationComplexDetail> list1 = evaluationDao.getEvaluationComplexDetail(complexTaskId);
            for (int i = 0; i < list1.size(); i++) {
                EvaluationComplexDetail ecDetail = list1.get(i);
                if (ecDetail.getTaskId().indexOf(",") > 0) {// 包含多项子项
                    evaluationDao.insertComplexResultByTaskList(ecDetail);
                } else {// 包含单项子项
                    evaluationDao.insertComplexResultBySingleTask(ecDetail);
                }
            }
            list = evaluationDao.getEvaluationComplexSumResult(str);
        }
        for (EvaluationComplexResult complexResult : list) {
            Map<String, String> tmp = new HashMap<String, String>();
            tmp.put("empName", complexResult.getEmpName());
            tmp.put("deptShow", complexResult.getDeptShow());
            tmp.put("score", complexResult.getScore());
            // 每单项分数  Result
            complexResult.setEvaluationType(evaluationType);
            List<EvaluationComplexResult> results = evaluationDao.getEvaluationComplexResult(complexResult);
            if (results.size() == 0) {
                for (EvaluationComplexDetail detail : details) {
                    tmp.put(detail.getId() + "-score", "未参加");
                }
            } else {
                for (EvaluationComplexResult result : results) {
                    tmp.put(result.getComplexDetailId() + "-score", "已参加");
                }
                if (details.size() != results.size()) {
                    for (EvaluationComplexDetail detail : details) {
                        int i = 0;
                        for (EvaluationComplexResult result : results) {
                            if (!detail.getId().equals(result.getComplexDetailId())) {
                                i++;
                            }
                        }
                        if (i == results.size()) {
                            tmp.put(detail.getId() + "-score", "未参加");
                        }
                    }
                }
            }
            data.add(tmp);
        }
        return CommonUtil.tableMap(data);
    }
    /**
     * 领导评教任务设置
     */
    public List<EvaluationTask> getLeaderTasks(EvaluationTask task){
        return evaluationDao.getLeaderTasks(task);
    }

    public List<EvaluationEmpsMenmbers> getLeaderListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers){
        return evaluationDao.getLeaderListTask(evaluationEmpsMenmbers);
    }

    public List<EvaluationTask> getMonitoerLeaderTask(EvaluationTask task){
        return evaluationDao.getMonitoerLeaderTask(task);
    }

    public List<EvaluationTask> getMonitoerLeaderTaskBySelf(EvaluationTask task){
        return evaluationDao.getMonitoerLeaderTaskBySelf(task);
    }

    public Map getLeaderTeacherEcharts(EchartsMenu echartsMenu){
        Map map = new HashMap();
        EchartsMenu name=evaluationDao.getLeaderTeacherNameEcharts(echartsMenu);
        map.put("nameEcharts",name);
        EchartsMenu sorce=evaluationDao.getLeaderTeacherSorceEcharts(echartsMenu);
        map.put("sorceEcharts",sorce);
        return map;
    }
    /**
     * 教师评教任务设置
     */
    public List<EvaluationTask> getTeacherTasks(EvaluationTask task){
        return evaluationDao.getTeacherTasks(task);
    }

    public List<EvaluationEmpsMenmbers> getTeacherListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers){
        return evaluationDao.getTeacherListTask(evaluationEmpsMenmbers);
    }

    public List<EvaluationTask> getMonitoerTeacherTask(EvaluationTask task){
        return evaluationDao.getMonitoerTeacherTask(task);
    }

    public List<EvaluationTask> getMonitoerTeacherTaskBySelf(EvaluationTask task){
        return evaluationDao.getMonitoerTeacherTaskBySelf(task);
    }
    public Map getTeacherTeacherEcharts(EchartsMenu echartsMenu){
        Map map = new HashMap();
        EchartsMenu name=evaluationDao.getLeaderTeacherNameEcharts(echartsMenu);
        map.put("nameEcharts",name);
        EchartsMenu sorce=evaluationDao.getLeaderTeacherSorceEcharts(echartsMenu);
        map.put("sorceEcharts",sorce);
        return map;
    }
    /**
     * 学生评教任务
     */
    public List<EvaluationTask> getStudentTasks(EvaluationTask task){
        return evaluationDao.getStudentTasks(task);
    }

    public List<EvaluationEmpsMenmbers> getStudentListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers){
        return evaluationDao.getStudentListTask(evaluationEmpsMenmbers);
    }

    public List<EvaluationTask> getMonitoerStudentTask(EvaluationTask task){
        return evaluationDao.getMonitoerStudentTask(task);
    }

    public List<EvaluationTask> getMonitoerStudentTaskBySelf(EvaluationTask task){
        return evaluationDao.getMonitoerStudentTaskBySelf(task);
    }

    public Map getStudentTeacherEcharts(EchartsMenu echartsMenu){
        Map map = new HashMap();
        EchartsMenu name=evaluationDao.getLeaderTeacherNameEcharts(echartsMenu);
        map.put("nameEcharts",name);
        EchartsMenu sorce=evaluationDao.getLeaderTeacherSorceEcharts(echartsMenu);
        map.put("sorceEcharts",sorce);
        return map;
    }
    /**
     * 同行评教任务设置
     */
    public List<EvaluationTask> getPeerTasks(EvaluationTask task){
        return evaluationDao.getPeerTasks(task);
    }

    public List<EvaluationEmpsMenmbers> getPeerListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers){
        return evaluationDao.getPeerListTask(evaluationEmpsMenmbers);
    }

    public List<EvaluationTask> getMonitoerPeerTask(EvaluationTask task){
        return evaluationDao.getMonitoerPeerTask(task);
    }

    public List<EvaluationTask> getMonitoerPeerTaskBySelf(EvaluationTask task){
        return evaluationDao.getMonitoerPeerTaskBySelf(task);
    }

    public Map getPeerTeacherEcharts(EchartsMenu echartsMenu){
        Map map = new HashMap();
        EchartsMenu name=evaluationDao.getLeaderTeacherNameEcharts(echartsMenu);
        map.put("nameEcharts",name);
        EchartsMenu sorce=evaluationDao.getLeaderTeacherSorceEcharts(echartsMenu);
        map.put("sorceEcharts",sorce);
        return map;
    }
    /**
     * 社会评教任务设置
     */
    public List<EvaluationTask> getParentTasks(EvaluationTask task){
        return evaluationDao.getParentTasks(task);
    }

    public List<EvaluationEmpsMenmbers> getParentListTask(EvaluationEmpsMenmbers evaluationEmpsMenmbers){
        return evaluationDao.getParentListTask(evaluationEmpsMenmbers);
    }

    public List<EvaluationTask> getMonitoerParentTask(EvaluationTask task){
        return evaluationDao.getMonitoerParentTask(task);
    }

    public List<EvaluationTask> getMonitoerParentTaskBySelf(EvaluationTask task){
        return evaluationDao.getMonitoerParentTaskBySelf(task);
    }

    public Map getParentTeacherEcharts(EchartsMenu echartsMenu){
        Map map = new HashMap();
        EchartsMenu name=evaluationDao.getLeaderTeacherNameEcharts(echartsMenu);
        map.put("nameEcharts",name);
        EchartsMenu sorce=evaluationDao.getLeaderTeacherSorceEcharts(echartsMenu);
        map.put("sorceEcharts",sorce);
        return map;
    }

    public List<EvaluationTask> getEvaluationSummaryTask(EvaluationTask task){
        return evaluationDao.getEvaluationSummaryTask(task);
    }

    public List<EvaluationEmp> getMonitoerSummaryByTaskId(EvaluationTask task){
        return evaluationDao.getMonitoerSummaryByTaskId(task);
    }

    public void saveEvaluationPushMember(EvaluationPush evaluationPush){
        evaluationDao.saveEvaluationPushMember(evaluationPush);
    }

    public void deleteEvaluationPushMember(@Param("id") String id){
        evaluationDao.deleteEvaluationPushMember(id);
    }

    public List<EvaluationPush> getEvaluationPushMembersByGroupId(@Param("id") String id){
        return evaluationDao.getEvaluationPushMembersByGroupId(id);
    }

    public void updateEvaluationTaskPushFlag(String id){
        evaluationDao.updateEvaluationTaskPushFlag(id);
    }

    public List<EvaluationTask> getEvaluationSummaryPushTask(EvaluationTask task){
        return evaluationDao.getEvaluationSummaryPushTask(task);
    }

    public List<EvaluationTask> getEvaluationTaskByTaskIds(@Param("taskIds") String taskIds){
        return evaluationDao.getEvaluationTaskByTaskIds(taskIds);
    }
    public Map getAllEvaluationEcharts(EchartsMenu echartsMenu){
        Map map = new HashMap();
        EchartsMenu student =evaluationDao.getStudentEvaluationEcharts(echartsMenu);
        map.put("studentEcharts",student);
        EchartsMenu leader=evaluationDao.getLeaderEvaluationEcharts(echartsMenu);
        map.put("leaderEcharts",leader);
        EchartsMenu teacher=evaluationDao.getTeacherEvaluationEcharts(echartsMenu);
        map.put("teacherEcharts",teacher);
        EchartsMenu peer=evaluationDao.getPeerEvaluationEcharts(echartsMenu);
        map.put("peerEcharts",peer);
        return map;
    }

    @Override
    public List<EvaluationTask> getUserTask(String loginId) {
        return evaluationDao.getUserTask(loginId);
    }

    @Override
    public  List<EvaluationTask> getTaskResultList(){
        return evaluationDao.getTaskResultList();
    }
}
