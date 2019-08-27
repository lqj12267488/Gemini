package com.goisan.system.controller;

import com.goisan.system.bean.*;
import com.goisan.system.service.EmpChangeLogService;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.LoginUserService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/6/28.
 */
@Controller
public class EmpChangeLogController {
    @Resource
    private EmpChangeLogService empChangeLogService;
    @Resource
    private EmpService empService;
    @Resource
    private LoginUserService loginUserService;

    @ResponseBody
    @RequestMapping("/empChangeLog/empTree")
    public ModelAndView empTree() {
        ModelAndView mv = new ModelAndView("/core/emp/empChangeLog/empTree");
        return mv;
    }

    @RequestMapping("/empChangeLog/toChangeEmpDept")
    public ModelAndView toChangeEmpDept(String personId) {
        ModelAndView mv = new ModelAndView("/core/emp/empChangeLog/changeDept");
        mv.addObject("personId", personId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/empChangeLog/updateEmpDept")
    private Message updateEmpDept(String personId, String deptIds) {
        String[] ids = deptIds.split(",");
        Select2 selectOld = empChangeLogService.getDeptNameByPersonId(personId);
        empService.deleteEmpDeptRelation(personId);
        LoginUser loginUser = CommonUtil.getLoginUser();
        for (String id : ids) {
            EmpDeptRelation empDeptRelation = new EmpDeptRelation();
            empDeptRelation.setId(CommonUtil.getUUID());
            empDeptRelation.setPersonId(personId);
            empDeptRelation.setDeptId(id);
            empDeptRelation.setCreateDept(loginUser.getDefaultDeptId());
            empDeptRelation.setCreator(loginUser.getPersonId());
            empDeptRelation.setValidFlag("1");
            empService.saveEmpDeptRelation(empDeptRelation);
        }
        Select2 selectNew = empChangeLogService.getDeptNameByPersonId(personId );
        EmpChangeLog empChangeLog = new EmpChangeLog();
        empChangeLog.setPersonId(personId);
        empChangeLog.setChangeType("1");
        empChangeLog.setNewCode(selectNew.getId());
        empChangeLog.setNewContent(selectNew.getText());
        empChangeLog.setOldCode(selectOld.getId());
        empChangeLog.setOldContent(selectOld.getText());
        empChangeLog.setCreateDept(loginUser.getDefaultDeptId());
        empChangeLog.setCreator(loginUser.getPersonId());
        empChangeLogService.saveLog(empChangeLog);
        loginUserService.upadtedefaultDeptByPersonid(personId, ids[0]);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/empChangeLog/serchList")
    public ModelAndView emp() {
        ModelAndView mv = new ModelAndView("/core/emp/empChangeLog/logGrid");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/empChangeLog/searchLog")
    public ModelAndView personLog(String personId) {
        ModelAndView mv = new ModelAndView("/core/emp/empChangeLog/personGrid");
        mv.addObject("personId", personId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/empChangeLog/searchGrid")
    public Map<String, List<EmpChangeLog>> searchGrid(EmpChangeLog empChangeLog) {
        Map<String, List<EmpChangeLog>> logList = new HashMap();
        String level = CommonUtil.getLoginUser().getLevel();
        String dept = CommonUtil.getDefaultDept();
        empChangeLog.setCreateDept(dept);
        empChangeLog.setLevel(level);
        List<EmpChangeLog> r = empChangeLogService.getEmpChangeLogList(empChangeLog);
        logList.put("data", r);
        return logList;
    }


    @RequestMapping("/empChangeLog/toChangeEmpStatus")
    public ModelAndView changeEmpStatus(String personId,String name) {
        ModelAndView mv = new ModelAndView("/core/emp/empChangeLog/changeStatus");
        Select2  data  = empChangeLogService.getStatusByPersonId(personId);
        mv.addObject("personId", personId);
        mv.addObject("name", name);
        mv.addObject("data", data);
        return mv;
    }


    @ResponseBody
    @RequestMapping("/empChangeLog/updateEmpStatus")
    private Message updateEmpStatus(String personId, String staffStatus) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        //旧状态，显示值
        Select2 selectOld = empChangeLogService.getStatusByPersonId(personId);

        //更加状态
        Emp emp = new Emp();
        emp.setPersonId(personId);
        emp.setStaffStatus(staffStatus);
        emp.setChangeDept(loginUser.getDefaultDeptId());
        emp.setChanger(loginUser.getPersonId());
        empService.updateEmp(emp);

        //新状态，显示值
        Select2 selectNew = empChangeLogService.getStatusByPersonId(personId);
        EmpChangeLog empChangeLog = new EmpChangeLog();
        empChangeLog.setPersonId(personId);
        empChangeLog.setChangeType("2");
        empChangeLog.setNewCode(selectNew.getId());
        empChangeLog.setNewContent(selectNew.getText());
        empChangeLog.setOldCode(selectOld.getId());
        empChangeLog.setOldContent(selectOld.getText());
        empChangeLog.setCreateDept(loginUser.getDefaultDeptId());
        empChangeLog.setCreator(loginUser.getPersonId());
        empChangeLogService.saveLog(empChangeLog);
        return new Message(1, "修改成功！", null);
    }

/*
    @ResponseBody
    @RequestMapping("/updaasdteEmp")
    public Message updateEmp(Emp emp) {
        emp.setChanger(CommonUtil.getPersonId());
        emp.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        empService.updateEmp(emp);
        return new Message(1, "修改成功！", null);
    }
*/

}
