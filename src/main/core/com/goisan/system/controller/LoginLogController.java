package com.goisan.system.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.LoginLog;
import com.goisan.system.service.LoginLogService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by admin on 2017/5/9.
 */
@Controller
public class LoginLogController {
    @Resource
    private LoginLogService loginLogService;
    @ResponseBody
    @RequestMapping("/loginLog/getLoginLogOederEmp")
    public Map<String, List> getLoginLogOrderEmp(){
        String personId = CommonUtil.getLoginUser().getPersonId();
        List<LoginLog> loginLogs = loginLogService.getLoginLogOrderEmp(personId);

        for(Iterator iter = loginLogs.iterator(); iter.hasNext();){
            LoginLog loginlog = (LoginLog)iter.next();
            if(loginlog.getUserId().equals(personId)){
                loginlog.setUserAccount(loginlog.getUserAccount()+"(我)");
            }
        }
        Map<String, List> reList = new HashMap<String, List>();
        reList.put("loginLogs",loginLogs);
        return reList;
    }

    @ResponseBody
    @RequestMapping("/loginLog/getLoginLogOederStudent")
    public Map<String, List> getLoginLogOrderStudent(){
        String personId = CommonUtil.getLoginUser().getPersonId();
        List<LoginLog> loginLogs = loginLogService.getLoginLogOrderStudent(personId);

        for(Iterator iter = loginLogs.iterator(); iter.hasNext();){
            LoginLog loginlog = (LoginLog)iter.next();
            if(loginlog.getUserId().equals(personId)){
                loginlog.setUserAccount(loginlog.getUserAccount()+"(我)");
            }
        }
        Map<String, List> reList = new HashMap<String, List>();
        reList.put("loginLogs",loginLogs);
        return reList;
    }

    public List<LoginLog> getLoginLog(){
        List<LoginLog> loginLogs = new ArrayList<LoginLog>();
        return loginLogs;
    }

    public List<LoginLog> getLoginLogByPersonId(String PersonId){
        List<LoginLog> loginLogs = new ArrayList<LoginLog>();
        return loginLogs;
    }

    public void delectLoginLog(LoginLog loginLogs){
    }

    @RequestMapping("/loginLog/request")
    public ModelAndView loginLogServiceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/loginlog/loginLogList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/loginLog/getLoginLogByAccountTime")
    public Map<String, Object> getLoginLogByAccountTime(LoginLog loginLogs, int draw, int start, int length ) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> loginLogsList = new HashMap();
        List<LoginLog> empList = loginLogService.getLoginLogByAccountTime(loginLogs);
        PageInfo<List<LoginLog>> info = new PageInfo(empList);
        loginLogsList.put("draw", draw);
        loginLogsList.put("recordsTotal", info.getTotal());
        loginLogsList.put("recordsFiltered", info.getTotal());
        loginLogsList.put("data", empList);
        //loginLogsMap.put("data", loginLogService.getLoginLogByAccountTime(loginLogs));
        return loginLogsList;
    }

}
