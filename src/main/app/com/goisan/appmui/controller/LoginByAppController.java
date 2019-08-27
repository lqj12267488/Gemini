package com.goisan.appmui.controller;

import com.goisan.evaluation.bean.EvaluationEmpsMenmbers;
import com.goisan.evaluation.service.EvaluationService;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.system.bean.LoginLog;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.service.LoginLogService;
import com.goisan.system.service.LoginUserService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.service.WorkflowService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginByAppController {
/*
    @Resource
    private MenuService menuService;
    @Resource
    private LoginUserService loginUserService;
    @Resource
    private DeptService deptService;
    @Resource
    private EmpService empService;
    @Resource
    private ClassService classService;
*/
    @Resource
    private LoginLogService loginLogService;
    @Resource
    private EvaluationService evaluationService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private LoginUserService loginUserService;
    @Resource
    private NoticeService noticeService;

    @RequestMapping("/loginApp/loginJsp")
    public ModelAndView loginJsp() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/loginByApp");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/loginApp/login")
    public Map<String, String> login(String loginId, String password, HttpServletRequest request) {
        Map<String, String> map = new HashMap<String, String>();
        Subject currentUser = SecurityUtils.getSubject();
        if (!currentUser.isAuthenticated()) {
            // 把用户名和密码封装为 UsernamePasswordToken 对象
            UsernamePasswordToken token = new UsernamePasswordToken(loginId, password);
            // rememberme
            token.setRememberMe(false);
            // 执行登录.
            try {
                currentUser.login(token);
            } catch (Exception e) {
                // 所有认证时异常的父类.
//                return new Message(1, "登录失败！", null);
                map.put("status","1");
                map.put("msg","登录失败！");
                // 所有认证时异常的父类.
                return map;
            }
        }

        LoginLog loginLog = new LoginLog();

        loginLog.setUserAccount(loginId);
        if(loginId.equals("sa")){
            loginLog.setUserId("sa");
        }else{
            loginLog.setUserId(CommonUtil.getPersonId());
        }
        try {
            loginLog = CommonUtil.getIpAndMac(loginLog,request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        loginLogService.insertLoginLog(loginLog);
//        return new Message(0, "登录成功！", null);
        map.put("status","0");
        map.put("msg","登录成功！");

        return map;
    }

    @RequestMapping("/loginApp/index")
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView();

        LoginUser loginUser = CommonUtil.getLoginUser();
        EvaluationEmpsMenmbers eEmpsMenmbers = new EvaluationEmpsMenmbers();
        if(!loginUser.getPersonId().equals("sa")){
            eEmpsMenmbers.setMemberPersonId(loginUser.getPersonId());
            eEmpsMenmbers.setMemberDeptId(loginUser.getDefaultDeptId());
            eEmpsMenmbers.setEvaluationFlag("0");
            eEmpsMenmbers.setEvaluationType("0");
        }
        List<EvaluationEmpsMenmbers> eEMenmbersList = evaluationService.getlistTask(eEmpsMenmbers);
        if(null != eEMenmbersList)
            mv.addObject("emCount", eEMenmbersList.size());
        else
            mv.addObject("emCount",0);

        eEmpsMenmbers.setEvaluationType("1");
        List<EvaluationEmpsMenmbers> eSMenmbersList = evaluationService.getlistTask(eEmpsMenmbers);
        if(null != eEMenmbersList)
            mv.addObject("smCount", eSMenmbersList.size());
        else
            mv.addObject("smCount",0);

        int unDoList = workflowService.getlistUnDoWorkFlowNameAppByType("%"+loginUser.getPersonId()+"%").size();
        if(!"" .equals(unDoList) )
            mv.addObject("unDoCount", unDoList);
        else
            mv.addObject("unDoCount",0);
        /**通知数量*/
        int notDoCount = noticeService.getNoticeCountApp(loginUser.getPersonId(),loginUser.getDefaultDeptId()).size();
        if(!"" .equals(notDoCount) )
            mv.addObject("notDoCount", notDoCount);
        else
            mv.addObject("notDoCount",0);
        /**公告数量*/
        int bulDoCount = noticeService.getBulletinCountApp(loginUser.getPersonId()).size();
        if(!"" .equals(bulDoCount) )
            mv.addObject("bulDoCount", bulDoCount);
        else
            mv.addObject("bulDoCount",0);


        String doList = workflowService.getlistWorkFlowDoneCountApp(loginUser.getName());
        if(!"" .equals(doList) )
            mv.addObject("doList", Integer.parseInt(doList));
        else
            mv.addObject("doList",0);

        String userType = loginUser.getUserType();
        LoginUser student = loginUserService.getLoginUserById(loginUser.getPersonId());
        String name = student.getName();
        mv.addObject("userType",userType);
        mv.addObject("name",name+",欢迎您!");
        mv.setViewName("/app/mainByApp");
        return mv;
    }

    // 提交等待頁面
    @RequestMapping("/appSaveLoading")
    public ModelAndView commonSaveLoading() {
        ModelAndView mv = new ModelAndView("/app/common/appSaveLoading");
        return mv;
    }

}