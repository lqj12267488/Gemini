package com.goisan.evaluation.controller;

import com.goisan.system.bean.*;
import com.goisan.evaluation.bean.*;
import com.goisan.system.service.EmpService;
import com.goisan.evaluation.service.EvaluationService;

import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.goisan.system.tools.Message;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by Admin on 2017/5/23.
 */
@Controller
public class EvaluationByAppController {
    @Resource
    public EvaluationService evaluationService;

    @Resource
    public EmpService empService;

    @RequestMapping("/evaluationApp/result/listTask")
    public ModelAndView listTask(String evaluationType) {
        ModelAndView mv = new ModelAndView("/app/result/taskList");
        String emJson = getTaskNameDownRefresh(1, evaluationType);
        mv.addObject("emJson", emJson);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluationApp/result/getTaskNameDownRefresh")
    public String getTaskNameDownRefresh(int page, String evaluationType) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        EvaluationEmpsMenmbers eEmpsMenmbers = new EvaluationEmpsMenmbers();
        if (!loginUser.getPersonId().equals("sa")) {
            eEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
            eEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());
            eEmpsMenmbers.setEvaluationFlag("0");
            eEmpsMenmbers.setEvaluationType(evaluationType);
        }
        List<EvaluationTask> task = evaluationService.getlistTaskNameApp(eEmpsMenmbers);
        return getJsonTaskList(task, page);
    }

    @ResponseBody
    @RequestMapping("/evaluationApp/result/getTaskNameUpRefresh")
    public String getTaskNameUpRefresh(int page, String evaluationFlag) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        EvaluationEmpsMenmbers eEmpsMenmbers = new EvaluationEmpsMenmbers();
        if (!loginUser.getPersonId().equals("sa")) {
            eEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
            eEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());
            eEmpsMenmbers.setEvaluationFlag("0");
            eEmpsMenmbers.setEvaluationType(evaluationFlag);
        }
        List<EvaluationTask> task = evaluationService.getlistTaskNameApp(eEmpsMenmbers);
        return getJsonTaskList(task, page);
    }

    public String getJsonTaskList(List<EvaluationTask> taskList, int page) {

        int from = (page - 1) * 10;
        int end = page * 10;
        int len = taskList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len + 10 : from;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len : end;

        String str = "";
        boolean b = true;
        Date date = new Date();

        for (int i = from; i < end; i++) {
            EvaluationTask task = taskList.get(i);
            String taskName = task.getTaskName();
            try {
                taskName = java.net.URLEncoder.encode(taskName, "UTF-8");
                taskName = java.net.URLEncoder.encode(taskName, "UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            String validFlag = "";

            if(date.after(task.getEndTime())){
                validFlag = "0";
            }else{
                validFlag = "1";
            }
            String obj = "{\"taskId\":\"" + task.getTaskId() + "\"," +
                    "\"taskName\":\"" + taskName + "\"," +
                    "\"endTime\":\"" + task.getEndTime() + "\"," +
                    "\"startTime\":\"" + task.getStartTime() + "\"," +
                    "\"validFlag\":\"" + validFlag + "\"," +
                    "\"planId\":\"" + task.getPlanId() + "\"}";

            if (b) {
                str = obj;
                b = false;
            } else {
                str = str + "," + obj;
            }
        }
        return "[" + str + "]";
    }


    @RequestMapping("/evaluationApp/result/listEmpsMenmbers")
    public ModelAndView listMenmbers(String taskId, String evaluationType) {
        ModelAndView mv = new ModelAndView("/app/result/taskEmpMenmberList");
        String emJson = listTaskDownRefresh(1, taskId, evaluationType);
        mv.addObject("emJson", emJson);
        mv.addObject("taskId", taskId);
        mv.addObject("evaluationType", evaluationType);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluationApp/result/listTaskDownRefresh")
    public String listTaskDownRefresh(int page, String taskId, String evaluationType) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        EvaluationEmpsMenmbers eEmpsMenmbers = new EvaluationEmpsMenmbers();
        if (!loginUser.getPersonId().equals("sa")) {
            eEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
            eEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());
            eEmpsMenmbers.setEvaluationFlag("0");
            eEmpsMenmbers.setEvaluationType(evaluationType);
        }
        eEmpsMenmbers.setTaskId(taskId);
        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getlistTask(eEmpsMenmbers);
        return getJsonEMList(eEMenmbersList, page);
    }

    @ResponseBody
    @RequestMapping("/evaluationApp/result/listTaskUpRefresh")
    public String listTaskUpRefresh(int page, String taskId, String evaluationType) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        EvaluationEmpsMenmbers eEmpsMenmbers = new EvaluationEmpsMenmbers();
        if (!loginUser.getPersonId().equals("sa")) {
            eEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
            eEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());
            eEmpsMenmbers.setEvaluationFlag("0");
            eEmpsMenmbers.setEvaluationType(evaluationType);
        }
        eEmpsMenmbers.setTaskId(taskId);
        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getlistTask(eEmpsMenmbers);
        return getJsonEMList(eEMenmbersList, page);
    }

    public String getJsonEMList(List<EvaluationEmpsMenmbers> eEMenmbersList, int page) {

        int from = (page - 1) * 10;
        int end = page * 10;
        int len = eEMenmbersList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len + 10 : from;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len : end;

        String str = "";
        boolean b = true;
        for (int i = from; i < end; i++) {
            EvaluationEmpsMenmbers eEMenmbers = eEMenmbersList.get(i);
            String taskName = eEMenmbers.getTaskName();
            String empName = eEMenmbers.getEmpName();
            try {
                taskName = java.net.URLEncoder.encode(taskName, "UTF-8");
                taskName = java.net.URLEncoder.encode(taskName, "UTF-8");
                empName = java.net.URLEncoder.encode(empName, "UTF-8");
                empName = java.net.URLEncoder.encode(empName, "UTF-8");

            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            String obj = "{\"taskId\":\"" + eEMenmbers.getTaskId() + "\"," +
                    "\"taskName\":\"" + taskName + "\"," +
                    "\"empDeptId\":\"" + eEMenmbers.getEmpDeptId() + "\"," +
                    "\"empPersonId\":\"" + eEMenmbers.getEmpPersonId() + "\"," +
                    "\"empName\":\"" + empName + "\"," +
                    "\"endTime\":\"" + eEMenmbers.getEndTime() + "\"," +
                    "\"startTime\":\"" + eEMenmbers.getStartTime() + "\"," +
                    "\"planId\":\"" + eEMenmbers.getPlanId() + "\"}";

            if (b) {
                str = obj;
                b = false;
            } else {
                str = str + "," + obj;
            }
        }
        return "[" + str + "]";
    }

    public String getJsonByIndex(String intStr, Index index, String leaf) {
        String str = "";

        String obj = "{'indexId':'" + index.getIndexId() + "'," +
                "'indexName':'" + index.getIndexName() + "'," +
                "'score':'" + index.getScore() + "'," +
                "'leafFlag':'" + index.getLeafFlag() + "'" +
                "'count':'" + leaf + "'" +
//                            "\"weights\":\""+index.getWeights()+"\","+
//                            "\"parentIndexId\":\""+index.getParentIndexId()+"\","+
//                "\"planId\":\""+index.getPlanId()+"\"" +
                "}";
        if (intStr.equals(""))
            str = obj;
        else
            str = intStr + "," + obj;
        return str;
    }

    @ResponseBody
    @RequestMapping("/evaluationApp/result/updateEmpsMenmbers")
    public Message updateEmpsMenmbers(EvaluationEmpsMenmbers eEMenmbers) {
        CommonUtil.update(eEMenmbers);
        evaluationService.updateEmpsMenmbers(eEMenmbers);
        return new Message(0, "删除成功！", null);
    }

    @RequestMapping("/evaluationApp/result/listResult")
    public ModelAndView gerlistResult(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        ModelAndView mv = new ModelAndView("/app/result/addScoreRemark");
        LoginUser loginUser = CommonUtil.getLoginUser();
        evaluationEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
        evaluationEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());
        List<Index> iList = evaluationService.getlistIndex(evaluationEmpsMenmbers.getPlanId());
        List<Index> iListReturn = new ArrayList<Index>();
        for (Iterator iListItemFir = iList.iterator(); iListItemFir.hasNext(); ) {
            //第一层
            Index indexFir = (Index) iListItemFir.next();
            if (indexFir.getParentIndexId().equals(evaluationEmpsMenmbers.getPlanId()) && indexFir.getLeafFlag()
                    .equals("1")) {
                //第一层 叶子
                iListReturn.add(indexFir);
            } else if (indexFir.getParentIndexId().equals(evaluationEmpsMenmbers.getPlanId()) && indexFir.getLeafFlag
                    ().equals("0")) {
                //第二层
                List<Index> iListSe = new ArrayList<Index>();
                for (Iterator iListItemSe = iList.iterator(); iListItemSe.hasNext(); ) {
                    Index indexSe = (Index) iListItemSe.next();
                    if (indexSe.getParentIndexId().equals(indexFir.getIndexId()) && indexSe.getLeafFlag().equals("1")) {
                        //第二层叶子
                        iListSe.add(indexSe);
                    } else if (indexSe.getParentIndexId().equals(indexFir.getIndexId()) && indexSe.getLeafFlag()
                            .equals("0")) {
                        //第三层
                        List<Index> iListThr = new ArrayList<Index>();
                        for (Iterator iListItemThr = iList.iterator(); iListItemThr.hasNext(); ) {
                            Index indexThr = (Index) iListItemThr.next();
                            if (indexThr.getParentIndexId().equals(indexSe.getIndexId())) {
                                //第三层叶子
                                iListThr.add(indexThr);
                            }
                        }
                        indexSe.setIndexList(iListThr);
                        iListSe.add(indexSe);
                    }
                }
                indexFir.setIndexList(iListSe);
                iListReturn.add(indexFir);
            }
        }
        mv.addObject("iList", iListReturn);

        String strJson = "{" +
                "\"taskId\":\"" + evaluationEmpsMenmbers.getTaskId() + "\"," +
                "\"empPersonId\":\"" + evaluationEmpsMenmbers.getEmpPersonId() + "\"," +
                "\"empDeptId\":\"" + evaluationEmpsMenmbers.getEmpDeptId() + "\"," +
                "\"empName\":\"" + evaluationEmpsMenmbers.getEmpName() + "\"," +
                "\"evaluationType\":\"" + evaluationEmpsMenmbers.getEvaluationType() + "\"," +
                "\"taskName\":\"" + evaluationEmpsMenmbers.getTaskName() + "\"" +
//                        "\"iList\":\"["+iListReturn+"]" +
                "}";
        mv.addObject("strJson", strJson);
        return mv;
    }

    @RequestMapping("/evaluationApp/result/overdueData")
    public ModelAndView overdueData(EvaluationEmpsMenmbers evaluationEmpsMenmbers) {
        CommonUtil.update(evaluationEmpsMenmbers);
        evaluationService.updateEmpsMenmbers(evaluationEmpsMenmbers);
        ModelAndView mv = new ModelAndView("/app/result/overdueData");
        mv.addObject("evaluationType", evaluationEmpsMenmbers.getEvaluationType());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluationApp/result/insertResult")
    public Message updateResult(String taskId, String empPersonId, String empDeptId, String returnValue, String
            empName) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String memberPersonId = loginUser.getPersonId();
        String memberDeptId = loginUser.getDefaultDeptId();
        String memberName = loginUser.getName();

        evaluationService.insertResult(taskId, empPersonId, empDeptId, returnValue, empName ,
                memberPersonId ,memberDeptId  , memberName);
/*
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

        evaluationService.delectResult(eResult);
        String[] result = returnValue.split("@@@@");
        for (int i = 0; i < result.length; i++) {
            String resultStr = result[i];
            String[] r = resultStr.split("##");
            String indexId = r[0];
            String score = r[1];
            if (r.length > 2) {
                String remark = r[2];
                eResult.setRemark(remark);
            }
            eResult.setIndexId(indexId);
            eResult.setScore(Double.parseDouble(score));
            eResult.setResultId(CommonUtil.getUUID());
            evaluationService.insertResult(eResult);
        }
        EvaluationEmpsMenmbers eEMenmbers = new EvaluationEmpsMenmbers();
        eEMenmbers.setTaskId(taskId);
        eEMenmbers.setMemberPersonId(memberPersonId);
        eEMenmbers.setMemberDeptId(memberDeptId);
        eEMenmbers.setEmpDeptId(empDeptId);
        eEMenmbers.setEmpPersonId(empPersonId);
        evaluationService.updateEvaluationEmpMenmber(eEMenmbers);*/
//        evaluationService.updateEmpsMenmbers(taskId);
        return new Message(0, "保存成功！", null);
    }

}
