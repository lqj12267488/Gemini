package com.goisan.system.controller;

import com.goisan.educational.arrayclass.service.ArrayClassService;
import com.goisan.system.bean.*;
import com.goisan.system.service.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.jasig.cas.client.authentication.AttributePrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

//import org.jasig.cas.client.authentication.AttributePrincipal;

/**
 * Created by Admin on 2017/4/11.
 */
@Controller
public class LoginController {
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
    /*
        @Resource
        private ParentService parentService;
    */
    @Resource
    private StudentParentRelationService studentParentRelationService;

    @ResponseBody
    @RequestMapping("/login")
    public Message login(String loginId, String password, String flag, HttpServletRequest request,
                         HttpServletResponse response) throws IOException {
        final Properties properties = new Properties();
        FileInputStream in = null;
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
                return message;
            }
        }
        try {
            if (!parameterService.checkMac()){
                return new Message(2, "系统已过试用期，登录失败！", null);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return message;
    }

    @RequestMapping("/navigation")
    public String navigation(HttpServletRequest request) {
        request.getSession().setAttribute("loginFlag", "1");
        return "navigation";
    }

    @Resource
    private StudentService studentService;

    @RequestMapping("/index")
    public ModelAndView index(HttpServletRequest request, HttpSession session, HttpServletResponse response, String system, String id) {
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
            if (roles.length() == 0){
                roles.append("''");
                mv.addObject("norole", "1");
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
        return mv;
    }

    @RequestMapping("/schoolLeaderIndex")
    public ModelAndView schoolLeaderIndex(HttpServletRequest request, HttpServletResponse response, String system, String id) {
        response.addHeader("X-Frame-Options", "DENY");
        ModelAndView mv = new ModelAndView();
        LoginUser loginUser = CommonUtil.getLoginUser();
        List<Menu> menus = new ArrayList<Menu>();
        String roles = "";
        String theme = loginUserService.getTheme(loginUser, system);
        String siteBackground = "";
        String siteContainer = "";
        if (theme != null) {
            siteBackground = theme.split(",")[0];
            siteContainer = theme.split(",")[1];
        } else {
/*
            if ("001".equals(id)) {
                siteBackground = "wall-num6";
                siteContainer = "container theme-black";
            }
*/
        }
        mv.addObject("siteBackground", siteBackground);
        mv.addObject("siteContainer", siteContainer);
        Set<String> rolesSet = loginUser.getRoles();
        if (rolesSet != null && rolesSet.size() != 0) {
            for (String role : rolesSet) {
                roles += "'" + role + "',";
            }
            roles = roles.substring(0, roles.length() - 1);
            menus = menuService.getMenuListByRoles(roles, system, id);
        }
        // 显示校领导主页
        mv.setViewName("schoolLeaderIndex");
        List<Dept> a = deptService.getDeptListByPersonId(loginUser.getPersonId());
        if (null != a) {
            int deptSize = a.size();
            mv.addObject("loginDeptListSize", deptSize);
        } else {
            mv.addObject("loginDeptListSize", 0);
        }
        mv.addObject("loginUserAccount", loginUser.getUserAccount());
        String photoUrl = CommonUtil.getLoginPhotoUrl(loginUser, getClass().getResource("/").getPath());
        mv.addObject("photoUrl", photoUrl);
        mv.addObject("loginID", loginUser.getPersonId());
        mv.addObject("menus", menus);
        return mv;
    }

    @RequestMapping("/top")
    public ModelAndView top() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("top");
        return mv;
    }

    @RequestMapping("/sys")
    public ModelAndView sys() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/dept/dept");
        return mv;
    }

    @RequestMapping("/building")
    public ModelAndView building() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/building");
        return mv;
    }


    @RequestMapping("/main")
    public ModelAndView main(String id, HttpSession session) {
        Subject subject = SecurityUtils.getSubject();
        LoginUser loginUser = (LoginUser) subject.getPrincipal();
        ModelAndView mv = new ModelAndView();
        StringBuilder roleIds = new StringBuilder();
        if (!"sa".equals(loginUser.getUserAccount())) {
            String groupIds = "";
            List<String> list = commonGroupService.getGroupIdByPersonId(CommonUtil.getPersonId());
            if (list.size() > 0) {
                for (String s : list) {
                    groupIds += "'" + s + "',";
                }
                List<String> list1 = commonGroupService.getRoleIdByGroupIds(groupIds.substring(0, groupIds.length() - 1));
                if (list1.size() > 0) {
                    for (String group : list1) {
                        roleIds.append("'").append(group).append("',");
                    }
                    roleIds = new StringBuilder(roleIds.substring(0, roleIds.length() - 1));
                }
            } else {
                for (String roleId : loginUser.getRoles()) {
                    roleIds.append("'").append(roleId).append("',");
                }
                if (roleIds.toString().isEmpty()) {
                    roleIds.append("xxx");
                } else {
                    roleIds = new StringBuilder(roleIds.substring(0, roleIds.length() - 1));
                }
            }
        }

        mv.addObject("menus", menuService.getMenusByRoles(roleIds.toString(), id));
        mv.setViewName("/main");
        return mv;
    }

    @RequestMapping("/center")
    public ModelAndView center() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("center");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/switchRole")
    public Message switchRole(String deptId) {
        Subject subject = SecurityUtils.getSubject();
        loginUserService.upadtedefaultDeptId(CommonUtil
                .getLoginUser().getUserAccount(), deptId);
        LoginUser switchToUser = null;
        String userAccount = CommonUtil.getLoginUser().getUserAccount();
        //教职员工
        if ("0".equals(CommonUtil.getLoginUser().getUserType()))
            switchToUser = loginUserService.getLoginUserRolesByLoginId(userAccount);
            //学生
        else if ("1".equals(CommonUtil.getLoginUser().getUserType()))
            switchToUser = loginUserService.getStudentRolesByLoginId(userAccount);
            //家长
        else if ("2".equals(CommonUtil.getLoginUser().getUserType()))
            switchToUser = loginUserService.getParentStudentUserRolesByLoginId(userAccount);

        subject.runAs(new SimplePrincipalCollection(switchToUser, ""));
        return new Message(1, "修改成功！", null);
    }

    @RequestMapping("/toChangeDept")
    public ModelAndView toChangeDept() {
        ModelAndView mv = new ModelAndView("/core/loginUser/changeDept");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getChangeDeptList")
    public Map<String, List> getChangeDeptList() {
        List<Dept> a = deptService.getDeptListByPersonId(CommonUtil.getLoginUser().getPersonId());
        String deptanme = "";
        for (Iterator<Dept> it = a.iterator(); it.hasNext(); ) {
            Dept dept = it.next();
            deptanme = getAllParentDeptName(dept.getDeptId(), "");
            dept.setDeptDescription(deptanme);
        }
        return CommonUtil.tableMap(a);
    }

    @ResponseBody
    @RequestMapping("/getLoginEmp")
    public Emp getLoginEmp() {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String deptid = loginUser.getDefaultDeptId();
//        String allAllParentDeptName = getAllParentDeptName(deptid,"");
        Dept dept = deptService.getDeptById(deptid);
        Emp emp = empService.getEmpByDeptIdAndPersonId(loginUser.getPersonId(), deptid);
//        emp.setDeptName(allAllParentDeptName);
        emp.setDeptName(dept.getDeptName());
        return emp;
    }

    @ResponseBody
    @RequestMapping("/getLoginPwd")
    public Map<String, List> getLoginPwd() {
        return CommonUtil.tableMap(deptService.getDeptListByPersonId(CommonUtil.getLoginUser().getPersonId()));
    }

    public String getAllParentDeptName(String deptid, String allPDeptName) {
        if (deptid != null) {
            Dept dept = deptService.getDeptById(deptid);
            if ("".equals(allPDeptName)) {
                allPDeptName = dept.getDeptName();
            } else {
                allPDeptName = dept.getDeptName() + "&nbsp;<span class=\"icon-arrow-right\"></span>&nbsp;" +
                        allPDeptName;
            }
            if ("0".equals(dept.getParentDeptId())) {
                return allPDeptName;
            } else {
                return getAllParentDeptName(dept.getParentDeptId(), allPDeptName);
            }
        } else {
            return "";
        }
    }

    @RequestMapping("/toChangeLoginPwd")
    public ModelAndView toChangeLoginPwd() {
        ModelAndView mv = new ModelAndView("/core/loginUser/changeLoginPwd");
        LoginUser loginUser = CommonUtil.getLoginUser();
        LoginUser loguser = new LoginUser();
        loguser.setPersonId(loginUser.getPersonId());
        if (null != loginUser.getQuestion() && !"".equals(loginUser.getQuestion())) {
            mv.addObject("answer", "*******");
            loguser.setQuestion(loginUser.getQuestion());
        }
        mv.addObject("loguser", loguser);
        return mv;
    }

    @RequestMapping("/toEditEmpBySelf")
    public ModelAndView toEditEmpBySelf() {
        ModelAndView mv = new ModelAndView("/core/loginUser/editEmpBySelf");
        LoginUser loginUser = CommonUtil.getLoginUser();
        String deptid = loginUser.getDefaultDeptId();
        Emp emp = empService.getEmpByDeptIdAndPersonId(loginUser.getPersonId(), deptid);
        if (null == emp.getPhotoUrl() || "".equals(emp.getPhotoUrl())) {
            emp.setPhotoUrl("dmitry_b.jpg");
        }
        String uploadFilePath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        uploadFilePath += "/userImg/" + loginUser.getPersonId();//+"."+type;
        File tempFile = new File(uploadFilePath);
        if (!tempFile.exists()) {
            emp.setPhotoUrl("dmitry_b.jpg");
        }
        mv.addObject("emp", emp);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/resetPwd")
    public ModelAndView resetPwd() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/retrieval");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/resetPwdGetQuestion")
    public LoginUser resetPwdGetQuestion(String userAccount) {
        LoginUser loginuser = loginUserService.getLoginUserByLoginId(userAccount);
        LoginUser user = new LoginUser();
        if (null == loginuser) {
            return null;
        } else {
            user.setUserAccount(loginuser.getUserAccount());
            user.setQuestion(loginuser.getQuestion());
            user.setPersonId(loginuser.getPersonId());
        }
        return user;
    }

    @ResponseBody
    @RequestMapping("/resetPwdCheckQue")
    public Message resetPwdCheckQue(String userAccount, String answer) {
        LoginUser loginuser = loginUserService.getLoginUserByLoginId(userAccount);
        if (loginuser.getAnswer().equals(answer)) {
            return new Message(1, "验证成功！", null);
        } else {
            return new Message(0, "验证失败！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/resetPwdDoChange")
    private Message resetPwdDoChange(LoginUser loginUser) {
        LoginUser loginuser = loginUserService.getLoginUserByLoginId(loginUser.getUserAccount());
        String pwd = loginUser.getPassword();
        if (pwd != null && !"".equals(pwd)) {
            pwd = (new SimpleHash("MD5", pwd, null, 1).toString());
            loginuser.setPassword(pwd);
        }
        loginUserService.upadtedeLoginUser(loginuser);
        return new Message(1, "保存成功！", null);
    }

    /**
     * 保存头像
     *
     * @param file
     * @return Required String parameter 'personId' is not present
     */
    @ResponseBody
    @RequestMapping("/loginuser/savePhoto")
    public Message savePhoto(@RequestParam(value = "file") CommonsMultipartFile file,
                             @RequestParam("EmppersonId") String EmppersonId) {
        String personId = CommonUtil.getPersonId();

        try {
            String name = file.getFileItem().getName();
            String type = name.substring(name.indexOf(".") + 1, name.length());
            InputStream in = file.getInputStream();
            byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据
            //String uploadFilePath1 = "E:\\yang\\workplace\\cancer3.0\\webapp\\src\\main\\webapp\\userImg
            // \\"+personId;//+"."+type
            String uploadFilePath = new File(getClass().getResource("/").getPath()).getParentFile().getParent()
                    .toString();
            uploadFilePath += "/userImg/" + personId;//+"."+type;
            //白城服务器绝对路径
            //String uploadFilePath ="D:\\apache-tomcat-7.0.63\\webapps\\ROOT\\userImg\\"+personId;//+"."+type;

            System.out.println("*********************************=====" + uploadFilePath);
            File tempFile = new File(uploadFilePath);
            if (tempFile.exists()) {
                boolean delResult = tempFile.delete();
//                System.out.println("删除已存在的文件：" + delResult);
            }
            FileOutputStream fos = new FileOutputStream(uploadFilePath);
            byte[] buffer = new byte[8192]; // 每次读8K字节
            int count = 0;
            // 开始读取上传文件的字节，并将其输出到服务端的上传文件输出流中
            while ((count = in.read(buffer)) > 0) {
                fos.write(buffer, 0, count); // 向服务端文件写入字节流
            }
            fos.close(); // 关闭FileOutputStream对象
            in.close(); // InputStream对象

            LoginUser loginUser = new LoginUser();
            loginUser.setPhotoName(name);
            loginUser.setPersonId(personId);
            loginUser.setPhotoUrl(personId);
            loginUser.setPhotoType(type);
            loginUserService.savePhoto(loginUser);
            LoginUser lUser = CommonUtil.getLoginUser();
            lUser.setPhotoUrl(personId);
        } catch (Exception e) {
            e.printStackTrace();
            return new Message(0, "上传失败！", null);
        }
        return new Message(1, "上传成功！", null);
    }

    @RequestMapping("/login/toEditEmpBySelf")
    public ModelAndView toEditPhoto() {
        ModelAndView mv = new ModelAndView("/core/loginUser/editPhoto");
        LoginUser loginUser = CommonUtil.getLoginUser();
        String url = loginUser.getPhotoUrl();
        if (null == url || "".equals(url)) {
            url = "dmitry_b.jpg";
        }
        String uploadFilePath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        uploadFilePath += "/userImg/" + loginUser.getPersonId();//+"."+type;
        File tempFile = new File(uploadFilePath);
        if (!tempFile.exists()) {
            url = "dmitry_b.jpg";
        }
        mv.addObject("url", url);
        mv.addObject("personid", loginUser.getPersonId());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/login/getSchedule")
    public Map<String, List> getSchedule() {
        List scheduleList = arrayClassService.getSchedule();
        Map<String, List> reList = new HashMap<String, List>();
        reList.put("scheduleList", scheduleList);
        return reList;
    }

    @RequestMapping("/changeTheme")
    public void changeTheme(String siteBackground, String siteContainer, HttpSession session) {
        LoginUser user = CommonUtil.getLoginUser();
        user.setSiteBackground(siteBackground);
        user.setSiteContainer(siteContainer);
        String system = (String) session.getAttribute("system");
        loginUserService.updateTheme(user, system);

    }

}
