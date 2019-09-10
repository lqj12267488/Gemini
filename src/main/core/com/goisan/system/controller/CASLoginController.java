package com.goisan.system.controller;

import com.goisan.educational.arrayclass.service.ArrayClassService;
import com.goisan.system.bean.*;
import com.goisan.system.service.*;
import com.goisan.system.tools.AESUtil;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.sun.xml.internal.bind.v2.model.core.ID;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.jasig.cas.client.authentication.AttributePrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

@Controller
public class CASLoginController {
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
    @Resource
    private LoginLogService loginLogService;
    @Resource
    private ArrayClassService arrayClassService;
    @Resource
    private ParameterService parameterService;
    @Resource
    private CommonGroupService commonGroupService;

    @Resource
    private StudentService studentService;
    /*
        @Resource
        private ParentService parentService;
    */
    @Resource
    private StudentParentRelationService studentParentRelationService;

    @ResponseBody
    @RequestMapping("/userLogin")
    public void login( String loginId, String password, String id, String abc,String type ,String tableName,String url,String businessId,String state,String editUrl,HttpServletRequest request,
                         HttpServletResponse response) throws Exception {
        final Properties properties = new Properties();
        String flag = null;
        FileInputStream in = null;
        //用户名解密
        byte[] bytes = AESUtil.parseHexStr2Byte(loginId);
        byte[] decrypt1 = AESUtil.decrypt(bytes, "12345");
        loginId = new String(decrypt1);
        //密码解密
        byte[] decode = AESUtil.parseHexStr2Byte(password);
        byte[] decrypt = AESUtil.decrypt(decode, "123456");
        password = new String(decrypt);
        try {
            in = new FileInputStream(this.getClass().getResource("/").getPath() + "/config.properties");
            properties.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String casFlag = properties.getProperty("casFlag");
        if ("true".equals(casFlag)) {
            AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();
            String casflag = "";
            if (principal != null) {
                Map attributes = principal.getAttributes();
                casflag = (String) attributes.get("casflag");//从cas端传过来的数据标识
                if ("1".equals(casflag)) {
                    loginId = (String) attributes.get("user_account");
                    password = null;
                }
            }
        }
        Subject currentUser = SecurityUtils.getSubject();
        LoginParameter loginParameter = loginLogService.getLoginParameter();
        Message message = new Message(0, "登录成功！", loginParameter.getSysUrl());
        if ("1".equals(flag)) {
            password = null;
        }
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
                message = new Message(1, "登录失败！", null);
                e.printStackTrace();

            }
        }
        LoginLog loginLog = new LoginLog();
        loginLog.setUserAccount(loginId);
        if ("sa".equals(loginId)) {
            loginLog.setUserId("sa");
        } else {
            loginLog.setUserId(CommonUtil.getPersonId());
        }
        try {
            loginLog = CommonUtil.getIpAndMac(loginLog, request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        loginLogService.insertLoginLog(loginLog);
        if ("1".equals(flag)) {
            try {
                response.sendRedirect(request.getContextPath() + loginParameter.getSysUrl());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        /**
         * 当前学期和当前学年*/
        String currentTerm = parameterService.getParameterValue();
        String currentYear = parameterService.getParameterYearValue();
        request.getSession().setAttribute("currentTerm", currentTerm);
        request.getSession().setAttribute("currentYear", currentYear);
        request.getSession().setAttribute("casFlag", casFlag);
        if ("true".equals(casFlag)) {
            response.sendRedirect(request.getContextPath() + loginParameter.getSysUrl());
        }
        response.sendRedirect(request.getContextPath()+"/index1?system=GLPT&id=001&tid="+id+"&abc="+abc+"&type="+type+"&tableName="+tableName+"&url="+url+"&businessId="+businessId+"&state="+state+"&editUrl="+editUrl+"&flag="+flag);

    }

    @RequestMapping("/casLogin")
    public void casLogin(String loginId, String password, String flag, HttpServletRequest request,
                      HttpServletResponse response) throws Exception {
        //cors解决跨域请求
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("P3P", "CP=CAO PSA OUR");
        if (request.getHeader("Access-Control-Request-Method") != null && "OPTIONS".equals(request.getMethod())) {
            response.addHeader("Access-Control-Allow-Methods", "POST,GET,TRACE,OPTIONS");
            response.addHeader("Access-Control-Allow-Headers", "Content-Type,Origin,Accept");
            response.addHeader("Access-Control-Max-Age", "120");
        }

        final Properties properties = new Properties();
        FileInputStream in = null;
        //用户名解密
        byte[] bytes = AESUtil.parseHexStr2Byte(loginId);
        byte[] decrypt1 = AESUtil.decrypt(bytes, "12345");
        loginId = new String(decrypt1);
        //密码解密
        byte[] decode = AESUtil.parseHexStr2Byte(password);
        byte[] decrypt = AESUtil.decrypt(decode, "123456");
        password = new String(decrypt);
        try {
            in = new FileInputStream(this.getClass().getResource("/").getPath() + "/config.properties");
            properties.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String casFlag = properties.getProperty("casFlag");
        if ("true".equals(casFlag)) {
            AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();
            String casflag = "";
            if (principal != null) {
                Map attributes = principal.getAttributes();
                casflag = (String) attributes.get("casflag");//从cas端传过来的数据标识
                if ("1".equals(casflag)) {
                    loginId = (String) attributes.get("user_account");
                    password = null;
                }
            }
        }
        Subject currentUser = SecurityUtils.getSubject();
        LoginParameter loginParameter = loginLogService.getLoginParameter();
        Message message = new Message(0, "登录成功！", loginParameter.getSysUrl());
        if ("1".equals(flag)) {
            password = null;
        }
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
                message = new Message(1, "登录失败！", null);
                e.printStackTrace();

            }
        }
        LoginLog loginLog = new LoginLog();
        loginLog.setUserAccount(loginId);
        if ("sa".equals(loginId)) {
            loginLog.setUserId("sa");
        } else {
            loginLog.setUserId(CommonUtil.getPersonId());
        }
        try {
            loginLog = CommonUtil.getIpAndMac(loginLog, request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        loginLogService.insertLoginLog(loginLog);
        if ("1".equals(flag)) {
            try {
                response.sendRedirect(request.getContextPath() + loginParameter.getSysUrl());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        /**
         * 当前学期和当前学年*/
        String currentTerm = parameterService.getParameterValue();
        String currentYear = parameterService.getParameterYearValue();
        request.getSession().setAttribute("currentTerm", currentTerm);
        request.getSession().setAttribute("currentYear", currentYear);
        request.getSession().setAttribute("casFlag", casFlag);

    }

    @RequestMapping("/index1")
    public ModelAndView index(HttpServletRequest request, HttpSession session, HttpServletResponse response, String system, String id,String tid,String abc,String type,String tableName,String url,String businessId,String state,String editUrl,String flag) {
        ModelAndView mv = new ModelAndView();
        response.addHeader("X-Frame-Options", "DENY");
        session.setAttribute("system", system);
        session.setAttribute("systemId", id);
        LoginUser loginUser = CommonUtil.getLoginUser();
        List<Menu> menus = new ArrayList<>();
        StringBuilder roles = new StringBuilder();
        String groupIds = "";
        String theme = loginUserService.getTheme(loginUser, system);
        String siteBackground = "";
        String siteContainer = "";
        if (theme != null) {
            siteBackground = theme.split(",")[0];
            siteContainer = theme.split(",")[1];
        } else {
            if ("001".equals(id)) {
                siteBackground = "wall-num6";
                siteContainer = "container theme-black";
            }
        }
        mv.addObject("siteBackground", siteBackground);
        mv.addObject("siteContainer", siteContainer);
        if ("sa".equals(loginUser.getUserAccount())) {
            menus = menuService.getMenuListSystem(system);
        } else {
            List<String> list = commonGroupService.getGroupIdByPersonId(CommonUtil.getPersonId());
            if (list.size() > 0) {
                for (String s : list) {
                    groupIds += "'" + s + "',";
                }
                List<String> list1 = commonGroupService.getRoleIdByGroupIds(groupIds.substring(0, groupIds.length() - 1));
                if (list1.size() > 0) {
                    for (String group : list1) {
                        roles.append("'").append(group).append("',");
                    }
                    roles = new StringBuilder(roles.substring(0, roles.length() - 1));
                }
            } else {
                Set<String> rolesSet = loginUser.getRoles();
                if (rolesSet != null && rolesSet.size() != 0) {
                    for (String role : rolesSet) {
                        roles.append("'").append(role).append("',");
                    }
                    roles = new StringBuilder(roles.substring(0, roles.length() - 1));
                }
            }
            menus = menuService.getMenuListByRoles(roles.toString(), system, id);
        }
        if (null == loginUser.getUserType() || "".equals(loginUser.getUserType()) || "0".equals(loginUser.getUserType())) {//教职员工
            mv.setViewName("index");
            List<Dept> a = deptService.getDeptListByPersonId(loginUser.getPersonId());
            if (null != a) {
                int deptSize = a.size();
                mv.addObject("loginDeptListSize", deptSize);
                String leaderFlag = "";
                for (Dept de : a) {
                    if (de.getDeptId().equals(loginUser.getDefaultDeptId())) {
                        leaderFlag = de.getLeaderFlag();
                        break;
                    }
                }
                mv.addObject("leaderFlag", leaderFlag);
            } else {
                mv.addObject("loginDeptListSize", 0);
                mv.addObject("leaderFlag", 0);
            }
        } else if ("1".equals(loginUser.getUserType())) {//学生
            mv.setViewName("studentIndex");
            List<ClassBean> a = classService.getClassListByStudentid(loginUser.getPersonId());
            if (null != a) {
                int deptSize = a.size();
                mv.addObject("loginDeptListSize", deptSize);
            } else {
                mv.addObject("loginDeptListSize", 0);
            }
        } else if ("2".equals(loginUser.getUserType())) {//学生家长
            mv.setViewName("parentIndex");
            mv.addObject("parentName", loginUser.getName());
            StudentParentRelation stuParRelation = new StudentParentRelation();
            stuParRelation.setParentId(loginUser.getPersonId());
            List a = studentParentRelationService.getStudentParentRelationList(stuParRelation);
            if (null != a && a.size() != 0) {
                int deptSize = a.size();
                String studentName = "";
                if (null != loginUser.getDefaultDeptId()) {
                    Student stu = studentService.getStudentNameByStudentId(loginUser.getDefaultDeptId());
                    if (null != stu)
                        studentName = stu.getDepartmentShow() + "&nbsp; > &nbsp;" +
                                stu.getMajorShow() + "&nbsp; > &nbsp;" +
                                stu.getClassShow() + "&nbsp; > &nbsp;" + stu.getName();
                }
                mv.addObject("loginStuListSize", deptSize);
                mv.addObject("studentName", studentName);
            } else {
                mv.addObject("loginStuListSize", 0);
            }
        }
        mv.addObject("loginUserAccount", loginUser.getUserAccount());
        String photoUrl = CommonUtil.getLoginPhotoUrl(loginUser, getClass().getResource("/").getPath());
        mv.addObject("photoUrl", photoUrl);
        mv.addObject("loginID", loginUser.getPersonId());
        mv.addObject("menus", menus);
        mv.addObject("system", system);
        mv.addObject("tid",tid);
        mv.addObject("abc",abc);
        mv.addObject("type",type);
        mv.addObject("tableName",tableName);
        mv.addObject("url",url);
        mv.addObject("businessId",businessId);
        mv.addObject("state",state);
        mv.addObject("editUrl",editUrl);
        mv.addObject("flag",flag);
        mv.addObject("i",0);
        return mv;
    }


}
