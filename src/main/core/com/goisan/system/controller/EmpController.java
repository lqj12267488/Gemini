package com.goisan.system.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.stuxuhai.jpinyin.PinyinException;
import com.github.stuxuhai.jpinyin.PinyinFormat;
import com.github.stuxuhai.jpinyin.PinyinHelper;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.logistics.assets.service.AssetsService;

import com.goisan.personnel.teachercontract.bean.TeacherContract;
import com.goisan.personnel.teachercontract.service.TeacherContractService;
import com.goisan.system.bean.*;
import com.goisan.system.service.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.PoiUtils;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.goisan.system.controller.StudentController.setHSSFValidation;

/**
 * Created by Admin on 2017/4/20.
 */
@Controller
public class EmpController {
    @Resource
    private EmpService empService;
    @Resource
    private DeptService deptService;
    @Resource
    private LoginUserService loginUserService;
    @Resource
    private EmpRangeService empRangeService;
    @Resource
    private RoleService roleService;
    @Resource
    private CommonService commonService;
    @Resource
    private AssetsService assetsService;

    @Resource
    private TeacherContractService teacherContractService;

    @ResponseBody
    @RequestMapping("/emp")
    public ModelAndView emp() {
        ModelAndView mv = new ModelAndView("/core/emp/emp");
        return mv;
    }

    @RequestMapping("/addEmp")
    public ModelAndView addEmp(String deptId) {
        ModelAndView mv = new ModelAndView("/core/emp/addEmp");
        if (deptId != null) {
            mv.addObject("deptId", deptId);
        }
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new java.util.Date());
        try {
            mv.addObject(
                    "newdate",
                    new Date(formatDate.parse(date).getTime())
            );
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return mv;
    }

    @RequestMapping("/toEmplist")
    public ModelAndView toEmplist(String deptId) {
        ModelAndView mv = new ModelAndView("/core/emp/empList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/saveEmp")
    public Message saveEmp(@RequestBody Emp emp) {
//        String root = new File(getClass().getResource("/").getPath()).getParentFile().getParentFile().getPath();
//        CommonUtil.generateImage(emp.getImg(), root + File.separator + "idcardimg" + File.separator + emp.getIdCard() + ".jpeg");
        Message message = new Message(1, "添加成功！", null);
        String idCard = CommonUtil.toIdcardCheck(emp.getIdCard());

        Emp empByIdCard = empService.getEmpByIdCard(idCard);
        if (empByIdCard == null) {
            Emp empnew = new Emp();
            empnew.setName(emp.getName());
            empnew.setDeptId(emp.getDeptId());
            empnew.setIdCard(idCard);
            empnew.setNation(emp.getNation());
            empnew.setSex(emp.getSex());
            empnew.setBirthday(emp.getBirthday());
            empnew.setAddress(emp.getAddress());
            empnew.setTel(emp.getTel());

            empnew.setNationality(emp.getNationality());
            empnew.setStaffId(emp.getStaffId());
            empnew.setUsedName(emp.getUsedName());
            empnew.setIdType(emp.getIdType());
            empnew.setNativePlaceProvince(emp.getNativePlaceProvince());
            empnew.setNativePlaceCity(emp.getNativePlaceCity());
            empnew.setNativePlaceCounty(emp.getNativePlaceCounty());
            empnew.setBirthPlace(emp.getBirthPlace());
            empnew.setPoliticalStatus(emp.getPoliticalStatus());
            empnew.setMaritalStatus(emp.getMaritalStatus());
            empnew.setHealthStatus(emp.getHealthStatus());
            empnew.setWorkTime(emp.getWorkTime());
            empnew.setToSchoolTime(emp.getToSchoolTime());
            empnew.setStaffSource(emp.getStaffSource());
            empnew.setStaffType(emp.getStaffType());
            empnew.setStaffFlag(emp.getStaffFlag());
            empnew.setEmployeForm(emp.getEmployeForm());
            empnew.setContractType(emp.getContractType());
            empnew.setTechnicalSkills(emp.getTechnicalSkills());
            empnew.setDoubleTypeFlag(emp.getDoubleTypeFlag());
            empnew.setCredentialsFlag(emp.getCredentialsFlag());
            empnew.setStuntTeacherFlag(emp.getStuntTeacherFlag());
            empnew.setWorkYear(emp.getWorkYear());
            empnew.setStaffStatus(emp.getStaffStatus());
            empnew.setStaffBelongs(emp.getStaffBelongs());
            empnew.setJob(emp.getJob());
            empnew.setNativePlace(emp.getNativePlace());
            empnew.setEntryDate(emp.getEntryDate());
            empnew.setPermanentResidence(emp.getPermanentResidence());
            empnew.setPermanentResidenceLocal(emp.getPermanentResidenceLocal());
            empnew.setLevels(emp.getLevels());
            empnew.setExaminePolitical(emp.getExaminePolitical());
            empnew.setEducationalLevel(emp.getEducationalLevel());
            empnew.setEducationTechnique(emp.getEducationTechnique());
            empnew.setGraduateSchool(emp.getGraduateSchool());
            empnew.setGraduateTime(emp.getGraduateTime());
            empnew.setMajor(emp.getMajor());
            empnew.setPositionalTitles(emp.getPositionalTitles());
            empnew.setPositionalLevel(emp.getPositionalLevel());
            empnew.setRemark(emp.getRemark());
            String personId = CommonUtil.getUUID();
            empnew.setPersonId(personId);
            empnew.setCreator(CommonUtil.getPersonId());
            empnew.setPost(emp.getPost());
            empnew.setClassPositions(emp.getClassPositions());
            empnew.setAcademicDegree(emp.getAcademicDegree());
//        empnew.setCreateTime(CommonUtil.getDate());
            empnew.setCreateDept(CommonUtil.getDefaultDept());
            empnew.setValidFlag("1");

            empnew.setDeadline(emp.getDeadline());
            empnew.setFilenumber(emp.getFilenumber());

            EmpDeptRelation edr = new EmpDeptRelation();
            edr.setId(CommonUtil.getUUID());
            edr.setPersonId(personId);
            edr.setDeptId(emp.getDeptId());
            edr.setPersonOrder(emp.getPersonOrder());
            edr.setCreateDept(CommonUtil.getDefaultDept());
            edr.setCreator(CommonUtil.getPersonId());
//        edr.setCreateTime(CommonUtil.getDate());
            LoginUser loginUser = new LoginUser();
            // String userAccount = emp.getName();
            String userAccount = null;
            try {
                userAccount = PinyinHelper.convertToPinyinString(emp.getName(), "", PinyinFormat
                        .WITHOUT_TONE);
            } catch (PinyinException e) {
                e.printStackTrace();
            }
            userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
            loginUser.setId(CommonUtil.getUUID());
            loginUser.setUserAccount(userAccount);
            loginUser.setPersonId(personId);
            loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
            loginUser.setUserType("0");
            loginUser.setDefaultDeptId(emp.getDeptId());
            loginUser.setCreateDept(CommonUtil.getDefaultDept());
            loginUser.setCreateTime(CommonUtil.getDate());
            loginUser.setCreator(CommonUtil.getPersonId());
            loginUser.setName(emp.getName());
//            loginUser.setIdCardPhotoUrl(File.separator + "idcardimg" + File.separator + emp.getIdCard() + ".jpeg");
            List<Emp> list = empService.getEmpStaffId(empnew.getStaffId());
            if (list.size() > 0) {
                message.setStatus(0);
                message.setMsg("教职工编号重复！");
            } else {
                empService.saveEmp(empnew, edr, loginUser);
            }

        } else {
            message.setStatus(0);
            message.setMsg("当前身份证已被录入！");
        }
        return message;
    }

/*    @ResponseBody
    @RequestMapping("/getEmpList")
    public Map<String, Object> getEmpList(Emp emp, Integer draw, int start, int length) {
        Map<String, Object> emps = new HashMap();
        PageHelper.startPage(start / length + 1, length);
        List<Emp> empList = empService.getEmpList(emp);
        PageInfo info = new PageInfo(empList);
        emps.put("draw", draw);
        emps.put("recordsTotal", info.getTotal());
        emps.put("recordsFiltered", info.getTotal());
        emps.put("data", empList);
        return emps;
    }*/

    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping("/getEmpList")
    public Map<String, Object> getEmpListByDeptId(Emp emp, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> emps = new HashMap();
        emp.setCreateDept(CommonUtil.getDefaultDept());
        emp.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Emp> empList = empService.getEmpListByDeptId(emp);
        PageInfo<List<Emp>> info = new PageInfo(empList);
        emps.put("draw", draw);
        emps.put("recordsTotal", info.getTotal());
        emps.put("recordsFiltered", info.getTotal());
        emps.put("data", empList);
        return emps;
    }

    @ResponseBody
    @RequestMapping("/emp/updateEmp")
    public Message updateEmp(@RequestBody Emp emp) {
        emp.setChanger(CommonUtil.getPersonId());
        emp.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        List<Emp> list = empService.getEmpStaffId(emp.getStaffId());
        if (list.size() > 1) {
            return new Message(0, "教职工编号重复！", null);
        } else {
            empService.updateEmp(emp);

            LoginUser LoginUser = new LoginUser();
            LoginUser.setPersonId(emp.getPersonId());
            LoginUser.setName(emp.getName());
            loginUserService.upadtedeLoginUser(LoginUser);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/deleteEmp")
    public Message deleteEmp(String personId, String deptId) {
        empService.deleteEmp(personId, "");
        loginUserService.deleteloginUser(personId);
//        List<EmpDeptRelation> empDeptRelationList = empService.getDeptByDeptIdAndPersonId
//                (personId, deptId);
//        if (empDeptRelationList.size() > 1) {
//            empService.deleteEmpDeptRelation(personId, deptId);
//        } else {
//            empService.deleteEmp(personId, deptId);
        loginUserService.deleteloginUser(personId);
//        }
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/toEditEmp")
    public ModelAndView toEditEmp(String personId, String deptId) {
        ModelAndView mv = new ModelAndView("/core/emp/editEmp");
        Emp emp = empService.getEmpByDeptIdAndPersonId(personId, deptId);

//        获取合同签订情况
        if (!StringUtils.isEmpty(emp.getPersonId())) {
            TeacherContract maxTeachCon = teacherContractService.getMaxTeachConByPersonId(emp.getPersonId());
            if (null != maxTeachCon) {
                emp.setContractType(maxTeachCon.getContractType());
            }
        }
        mv.addObject("emp", emp);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getChangeDeptTree")
    public List<Tree> getChangeDeptTree(String personId) {
        List<Tree> trees = deptService.getDeptTree();
        List<String> depts = empService.getDeptByPersonId(personId);
        for (Tree tree : trees) {
            for (String dept : depts) {
                if (tree.getId().equals(dept)) {
                    tree.setChecked(true);
                }
            }
            tree.setOpen(true);
        }
        Tree root = new Tree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

    @RequestMapping("/toChangeLevel")
    public String toChangeLevel(String personId, Model model) {
        String level = empService.getPersonLevel(personId);
        model.addAttribute("level", level);
        model.addAttribute("personId", personId);
        return "core/emp/changeLevel";
    }

    @ResponseBody
    @RequestMapping("/getLevel")
    public List<Select2> getLevel() {
        List<Select2> list = new ArrayList<>();
        int level = Integer.parseInt(CommonUtil.getLoginUser().getLevel());
        for (Select2 select : empService.getLevels(level)) {
            if (Integer.parseInt(select.getId()) >= level) {
                list.add(select);
            }
        }
        return list;
    }

    @ResponseBody
    @RequestMapping("/saveLevel")
    public Message saveLevel(LoginUser loginUser) {
        empService.updateLevel(loginUser);
        return new Message(1, "修改成功！", null);
    }

    @RequestMapping("/toChangeEmpDept")
    public ModelAndView toChangeEmpDept(String personId) {
        ModelAndView mv = new ModelAndView("/core/emp/changeDept");
        mv.addObject("personId", personId);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/updateEmpDept")
    private Message updateEmpDept(String personId, String deptIds) {
        String[] ids = deptIds.split(",");
        empService.deleteEmpDeptRelation(personId);
        for (String id : ids) {
            EmpDeptRelation empDeptRelation = new EmpDeptRelation();
            empDeptRelation.setId(CommonUtil.getUUID());
            empDeptRelation.setPersonId(personId);
            empDeptRelation.setDeptId(id);
            empDeptRelation.setCreateDept(CommonUtil.getDefaultDept());
            empDeptRelation.setCreator(CommonUtil.getPersonId());
            empDeptRelation.setValidFlag("1");
            empService.saveEmpDeptRelation(empDeptRelation);
        }
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/checkUserAccount")
    private String checkUserAccount(String useraccount) {
        String str = loginUserService.getUserAccount(useraccount);
        if (str == null || "".equals(str)) {
            return "true";
        } else {
            return "false";
        }
    }

    @ResponseBody
    @RequestMapping("/checkUserPwd")
    private String checkUserPwd(String pwd) {
        pwd = (new SimpleHash("MD5", pwd, null, 1).toString());
        String password = CommonUtil.getLoginUser().getPassword();
        if (pwd.equals(password)) {
            return "true";
        } else {
            return "false";
        }
    }

    @ResponseBody
    @RequestMapping("/checkQAnswer")
    private String checkQAnswer(String answer) {
        String LoginUseranswer = CommonUtil.getLoginUser().getAnswer();
        if (answer.equals(LoginUseranswer)) {
            return "true";
        } else {
            return "false";
        }
    }

    @ResponseBody
    @RequestMapping("/saveQueAns")
    private Message saveQueAns(LoginUser loginUser) {
        LoginUser login = CommonUtil.getLoginUser();
        login.setQuestion(loginUser.getQuestion());
        login.setAnswer(loginUser.getAnswer());

        loginUser.setChangeDept(login.getDefaultDeptId());
        loginUser.setChanger(login.getPersonId());
        loginUserService.upadtedeLoginUser(loginUser);
        return new Message(1, "保存成功！", null);
    }


    @ResponseBody
    @RequestMapping("/saveLoginPwd")
    private Message saveLoginPwd(LoginUser loginUser) {
        String pwd = loginUser.getPassword();
        LoginUser login = CommonUtil.getLoginUser();
        if (pwd != null && !"".equals(pwd)) {
            pwd = (new SimpleHash("MD5", pwd, null, 1).toString());
            loginUser.setPassword(pwd);
            login.setPassword(pwd);
        }
        loginUser.setChangeDept(login.getDefaultDeptId());
        loginUser.setChanger(login.getPersonId());
        loginUserService.upadtedeLoginUser(loginUser);
        return new Message(1, "保存成功！", null);
    }


    @ResponseBody
    @RequestMapping("/updateEmpBySelf")
    private Message updateEmpBySelf(Emp emp) {
        Emp newemp = new Emp();
        newemp.setPersonId(emp.getPersonId());
        newemp.setAddress(emp.getAddress());
        newemp.setTel(emp.getTel());

        newemp.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        newemp.setChanger(CommonUtil.getPersonId());
        empService.updateEmp(emp);

        LoginUser LoginUser = new LoginUser();
        LoginUser.setPersonId(emp.getPersonId());
        LoginUser.setName(emp.getName());
        loginUserService.upadtedeLoginUser(LoginUser);

        return new Message(1, "保存成功！", null);
    }

    @ResponseBody
    @RequestMapping("/getDeptEmpChartData")
    protected Map<String, List> getDeptEmpChartData() {
        List<Map> empsList = new ArrayList<Map>();
        String dept = CommonUtil.getDefaultDept();
        List<Emp> emps = empService.GroupEmpByDept();
        List nameList = new ArrayList();
        for (int i = 0; i < emps.size(); i++) {
            Map map = new HashMap();
            map.put("name", emps.get(i).getDeptId());
            map.put("value", emps.get(i).getPersonOrder());
            empsList.add(map);
            nameList.add(emps.get(i).getDeptId());
        }
        Map<String, List> reList = new HashMap<String, List>();
        reList.put("empsList", empsList);
        reList.put("nameList", nameList);
        return reList;
    }

    //教职工部门关系跳转
    @ResponseBody
    @RequestMapping("/emp/range")
    public ModelAndView emprange() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/emprange/empRange");
        return mv;
    }

    //教职工部门关系列表页
    @ResponseBody
    @RequestMapping("/emp/range/getEmpRangeList")
    public Map<String, Object> getEmpRangeList(EmpRange empRange, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> empRangeList = new HashMap<String, Object>();
        empRange.setCreator(CommonUtil.getPersonId());
        empRange.setCreateDept(CommonUtil.getDefaultDept());
        empRange.setLevel(CommonUtil.getLoginUser().getLevel());
        List<EmpRange> list = empRangeService.getEmpRangeList(empRange);
        PageInfo<List<EmpRange>> info = new PageInfo(list);
        empRangeList.put("draw", draw);
        empRangeList.put("recordsTotal", info.getTotal());
        empRangeList.put("recordsFiltered", info.getTotal());
        empRangeList.put("data", list);
        return empRangeList;
    }


    //新增教职工部门关系URL
    @RequestMapping("/emp/range/editRange")
    public ModelAndView editRange() {
        ModelAndView mv = new ModelAndView("/core/emprange/editRange");
        mv.addObject("head", "教职工部门关系新增");
        return mv;
    }

    //修改教职工部门关系URL
    @ResponseBody
    @RequestMapping("/emp/range/getEmpRangeById")
    public ModelAndView getEmpRangeById(String id) {
        ModelAndView mv = new ModelAndView("/core/emprange/editRange");
        EmpRange empRange = empRangeService.getEmpRangeById(id);
        mv.addObject("head", "教职工部门关系修改");
        mv.addObject("empRange", empRange);
        return mv;
    }

    //保存方法（CommonInsertUpdate）
    @ResponseBody
    @RequestMapping("/emp/range/saveEmpRange")
    public Message saveEmpRange(EmpRange empRange) {
        if (null == empRange.getId() || "".equals(empRange.getId())) {
            String personId = empRange.getPersonId().split(",")[1];
            List<EmpRange> empRanges = empRangeService.getEmpRangeByEmpId(personId);
            if (empRanges.size() > 0) {
                return new Message(1, "该人员已经配置过，请修改原有配置！", null);
            } else {
                empRange.setPersonId(personId);
                empRange.setCreator(CommonUtil.getPersonId());
                empRange.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                empRange.setId(CommonUtil.getUUID());
                empRangeService.insertEmpRange(empRange);
                return new Message(1, "新增成功！", null);
            }
        } else {
            empRange.setChanger(CommonUtil.getPersonId());
            empRange.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            empRangeService.updatEmpRangeById(empRange);
            return new Message(1, "修改成功！", null);
        }
    }

    //删除教职工部门关系
    @ResponseBody
    @RequestMapping("/emp/range/deleteEmpRangeById")
    public Message deleteEmpRangeById(String id) {
        empRangeService.deleteEmpRangeById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/toAssignRole")
    public ModelAndView toAssignRole(String personId, String deptId) {
        List<Tree> roles = empService.getRoleList();
        List<String> empRoles = empService.getEmpRole(personId, deptId);
        for (Tree role : roles) {
            for (String empRole : empRoles) {
                if (role.getId().equals(empRole)) {
                    role.setChecked(true);
                }
            }
        }
        String roleTree = null;
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            roleTree = objectMapper.writeValueAsString(roles);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        ModelAndView mv = new ModelAndView("/core/emp/assignRole");
        mv.addObject("data", roleTree);
        mv.addObject("personId", personId);
        mv.addObject("deptId", deptId);
        /***/
        mv.addObject("flag","1");
        return mv;

    }

    @ResponseBody
    @RequestMapping("/toAssignRoles")
    public ModelAndView toAssignRoles(String personIds, String deptId) {
        List<Tree> roles = empService.getRoleList();
        List<String> empRoles = empService.getEmpRole(personIds.substring(0, personIds.length() - 2), deptId);
        for (Tree role : roles) {
            for (String empRole : empRoles) {
                if (role.getId().equals(empRole)) {
                    role.setChecked(true);
                }
            }
        }
        String roleTree = null;
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            roleTree = objectMapper.writeValueAsString(roles);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        ModelAndView mv = new ModelAndView("/core/emp/assignRole");
        mv.addObject("data", roleTree);
        mv.addObject("personId", personIds.replaceAll("'", ""));
        mv.addObject("deptId", deptId);
        return mv;

    }

    @ResponseBody
    @RequestMapping("/changeEmpRole")
    public Message changeEmpRole(String ids, String personId, String deptId) {
        empService.changeEmpRole(ids, personId, deptId);
        return new Message(1, "分配成功！", null);
    }

    private HSSFCellStyle createBorderStyle(HSSFWorkbook wb, HSSFFont font) {
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setWrapText(true);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        return cellStyle;
    }

    @RequestMapping("/exportEmp")
    public void exportEmp(Emp emp1, HttpServletResponse response) throws Exception {
        HashMap<String, List<Emp>> hashMap = new HashMap<>();
        //查询部门
        List<String> list = empService.selectDeptName();
        //根据部门查询
        List<Emp> empList1 = null;
        if ("undefined".equals(emp1.getDeptId()) || "0".equals(emp1.getDeptId()) ||"001".equals(emp1.getDeptId()) ){
            for (String str : list) {
                empList1 = empService.selectList2(str,null);
                hashMap.put(str, empList1);
            }
        }else{
            empList1 = empService.selectList2(null,emp1.getDeptId());
            hashMap.put(emp1.getName(), empList1);
        }

        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("新疆现代职业技术学院教职工花名册");

        HSSFFont headFont = PoiUtils.createFont(wb, 16, "宋体", Boolean.TRUE, null);
        HSSFFont titleFont = PoiUtils.createFont(wb, 9, "宋体", Boolean.TRUE, null);
        HSSFFont textFont = PoiUtils.createFont(wb, 9, "宋体", Boolean.FALSE, null);

        HSSFCellStyle headStyle = PoiUtils.createStyle(wb, headFont, Boolean.FALSE);
        headStyle.setAlignment(HorizontalAlignment.LEFT);
        HSSFCellStyle titleStyle = PoiUtils.createStyle(wb, titleFont, Boolean.TRUE);
        HSSFCellStyle textStyle = PoiUtils.createStyle(wb, textFont, Boolean.TRUE);

        setColumnDefaultStyleAndWidth(sheet);

        HSSFRow rowHead = sheet.createRow(0);
        rowHead.setHeightInPoints(35);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 78));
        PoiUtils.createCellWithStyleAndValue(rowHead,0,"新疆现代职业技术学院教职工花名册",headStyle);

        /**设置固定栏*/
        sheet.createFreezePane(5,4);

        sheet.addMergedRegion(new CellRangeAddress(1, 3, 0, 0));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 1, 1));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 2, 2));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 3, 3));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 4, 4));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 5, 7));

        sheet.addMergedRegion(new CellRangeAddress(1, 3, 8, 8));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 9, 9));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 10, 10));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 11, 11));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 12, 12));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 13, 13));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 14, 14));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 15, 15));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 16, 16));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 17, 17));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 18, 18));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 19, 19));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 20, 20));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 21, 21));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 22, 22));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 23, 23));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 24, 24));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 25, 25));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 26, 26));

        sheet.addMergedRegion(new CellRangeAddress(1, 2, 27, 28));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 29, 31));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 32, 32));

        sheet.addMergedRegion(new CellRangeAddress(1, 1, 33, 41));
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 33, 35));
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 36, 38));
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 39, 41));

        sheet.addMergedRegion(new CellRangeAddress(1, 1, 42, 45));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 42, 42));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 43, 43));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 44, 44));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 45, 45));

        sheet.addMergedRegion(new CellRangeAddress(1, 3, 46, 46));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 47, 47));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 48, 48));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 49, 49));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 50, 50));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 51, 51));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 52, 52));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 53, 53));

        sheet.addMergedRegion(new CellRangeAddress(1, 1, 54, 56));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 54, 54));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 55, 55));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 56, 56));

        /**档案资料*/
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 57, 77));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 57, 57));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 58, 58));
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 59, 60));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 61, 61));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 62, 62));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 63, 63));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 64, 64));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 65, 65));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 66, 66));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 67, 67));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 68, 68));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 69, 69));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 70, 70));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 71, 71));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 72, 72));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 73, 73));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 74, 74));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 75, 75));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 76, 76));
        sheet.addMergedRegion(new CellRangeAddress(2, 3, 77, 77));
        sheet.addMergedRegion(new CellRangeAddress(1, 3, 78, 78));

        HSSFRow hssfRow = sheet.createRow(1);
        hssfRow.setHeightInPoints(18);

        PoiUtils.createCellWithStyleAndValue(hssfRow,0,"序号",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,1,"部门",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,2,"人数",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,3,"姓名",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,4,"岗位",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,5,"职级",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,8,"入职日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,9,"婚姻状况",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,10,"性别",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,11,"族别",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,12,"出生日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,13,"年龄",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,14,"身份证账号",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,15,"联系方式",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,16,"籍贯",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,17,"户口所在地",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,18,"户口所属地区",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,19,"是否政审",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,20,"现地址",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,21,"政治面貌",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,22,"文化程度",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,23,"教育方式",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,24,"毕业院校",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,25,"专业",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,26,"毕业时间",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,27,"职称",titleStyle);

        PoiUtils.createCellWithStyleAndValue(hssfRow,29,"试用期限截止日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,32,"转正日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,33,"劳动合同",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,42,"兼职协议",titleStyle);

        PoiUtils.createCellWithStyleAndValue(hssfRow,46,"退休证明",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,47,"份数",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,48,"保密协议",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,49,"试用期工资",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,50,"转正系数",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,51,"转正工资",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,52,"离职日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,53,"校龄",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,54,"保险福利",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,57,"档案资料",titleStyle);
        PoiUtils.createCellWithStyleAndValue(hssfRow,78,"备注",titleStyle);

        HSSFRow row2 = sheet.createRow(2);
        row2.setHeightInPoints(28);
        PoiUtils.createCellWithStyleAndValue(row2,33,"第一次签订",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,36,"第二次签订",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,39,"第三次签订",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,42,"协议开始日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,43,"协议截止日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,44,"协议期限",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,45,"人员性质",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row2,54,"退休",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,55,"社保号",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,56,"数量",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row2,57,"银行卡号",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,58,"一寸照",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,59,"身份证",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row2,61,"户口",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,62,"毕业证",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,63,"学位证",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,64,"解除劳动合同",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,65,"计算机",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,66,"英语",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,67,"国语水平",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,68,"普通话",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,69,"教师资料",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,70,"其它资料",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,71,"驾驶证",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,72,"电工证",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,73,"退休证",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,74,"退休证明",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,75,"外单位交社保证明",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,76,"人事档案",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row2,77,"其它资料",titleStyle);

        HSSFRow row3 = sheet.createRow(3);
        row3.setHeightInPoints(28);
        PoiUtils.createCellWithStyleAndValue(row3,5,"职级",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,6,"文件号",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,7,"期限",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,27,"名称",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,28,"级别",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row3,29,"试用开始日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,30,"试用截止日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,31,"试用期限",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row3,33,"合同开始日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,34,"合同截止日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,35,"合同期限",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row3,36,"合同开始日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,37,"合同截止日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,38,"合同期限",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row3,39,"合同开始日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,40,"合同截止日期",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,41,"合同期限",titleStyle);

        PoiUtils.createCellWithStyleAndValue(row3,59,"数量",titleStyle);
        PoiUtils.createCellWithStyleAndValue(row3,60,"身份证期限",titleStyle);

        setRowBorder(wb,titleStyle,1,3,0,78);

        int tmp =4 ;
        int i = 1;
        Set<String> set = hashMap.keySet();
        for (String str : set) {
            //合并单元格
            List<Emp> empList = hashMap.get(str);
            if (empList.size() != 0 && empList.size() != 1) {
                    sheet.addMergedRegion(new CellRangeAddress(tmp, tmp+empList.size()-1, 1, 1));
                    sheet.addMergedRegion(new CellRangeAddress(tmp, tmp+empList.size()-1, 2, 2));
                }
                for (int j = 0; j < empList.size(); j++) {
                    Emp emp = empList.get(j);
                    HSSFRow row = sheet.createRow(tmp);
                    row.setHeightInPoints(25);
                    String str1 = emp.getClassPositionsShow();
                    //创建HSSFCell对象
                    PoiUtils.createCellWithStyleAndValue(row,0,String.valueOf(i),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,1, emp.getDeptName(),titleStyle);
                    PoiUtils.createCellWithStyleAndValue(row,2,String.valueOf(empList.size()),titleStyle);
                    PoiUtils.createCellWithStyleAndValue(row,3, emp.getName(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,4, emp.getJobShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,5,emp.getClassPositionsShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,6,emp.getFilenumber(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,7,emp.getDeadline(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,8,emp.getEntryDateShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,9,emp.getMaritalStatusShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,10,emp.getSexShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,11,emp.getNationShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,12,emp.getBirthdayShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,13,emp.getAge(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,14,emp.getIdCard(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,15,emp.getTel(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,16,emp.getNativePlace(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,17,emp.getPermanentResidence(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,18,emp.getPermanentResidenceLocalShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,19,emp.getExaminePoliticalShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,20,emp.getAddress(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,21,emp.getPoliticalStatusShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,22,emp.getEducationalLevelShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,23,emp.getEducationTechniqueShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,24,emp.getGraduateSchool(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,25,emp.getMajor(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,26,emp.getGraduateTimeShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,27,emp.getPositionalTitles(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,28,emp.getPositionalLevelShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,29,emp.getSyStartTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,30,emp.getSyEndTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,31,emp.getSyContractPeriod(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,32,emp.getPositiveTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,33,emp.getFirstStartTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,34,emp.getFirstEndTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,35,emp.getFirstContractPeriod(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,36,emp.getSecStartTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,37,emp.getSecEndTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,38,emp.getSecContractPeriod(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,39,emp.getThirdStartTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,40,emp.getThirdEndTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,41,emp.getThirdContractPeriod(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,42,emp.getJzStartTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,43,emp.getJzEndTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,44,emp.getJzContractPeriod(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,45,emp.getPersonNatureShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,46,emp.getRetireCert(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,47,emp.getNums(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,48,emp.getConfidentAgreement(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,49,emp.getTrpidSalary(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,50,emp.getPositiveCoff(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,51,emp.getPositiveSalary(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,52,emp.getRetireTime(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,53,emp.getSchoolAge(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,54,emp.getRetireNy(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,55,emp.getSsnumber(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,56,emp.getCounts(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,57,emp.getBankId(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,58,emp.getPhoneShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,59,emp.getNums(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,60,emp.getDeadline(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,61,emp.getAccountShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,62,emp.getDiplomaShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,63,emp.getDegreeCertShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,64,emp.getDisContractShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,65,emp.getComputerShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,66,emp.getEnglishShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,67,emp.getPthLevelShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,68,emp.getPutonghuaShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,69,emp.getTeachCertShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,70,emp.getOtherCertShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,71,emp.getDriverCertShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,72,emp.getEleCertShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,73,emp.getRetireCertShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,74,emp.getRetireProveShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,75,emp.getExtSsCertShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,76,emp.getPersonFileShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,77,emp.getOtherInfoShow(),textStyle);
                    PoiUtils.createCellWithStyleAndValue(row,78,emp.getRemark(),textStyle);
                    tmp++;
                    i++;
                }
            }
            PoiUtils.outFile(wb,"新疆现代职业技术学院教职工花名册",response);
    }

    public void setColumnDefaultStyleAndWidth(HSSFSheet sheet) {
        sheet.setDefaultRowHeightInPoints(28);
        sheet.setColumnWidth(0,4* 256);
        sheet.setColumnWidth(1,7* 256);
        sheet.setColumnWidth(2,4* 256);
        sheet.setColumnWidth(3,12* 256);
        sheet.setColumnWidth(4,12* 256);
        sheet.setColumnWidth(5,7* 256);

        sheet.setColumnWidth(9,4* 256);
        sheet.setColumnWidth(10,4* 256);
        sheet.setColumnWidth(11,4* 256);
        sheet.setColumnWidth(13,4* 256);
        sheet.setColumnWidth(14,30* 256);
        sheet.setColumnWidth(16,5* 256);
        sheet.setColumnWidth(17,30* 256);
        sheet.setColumnWidth(19,4* 256);
        sheet.setColumnWidth(20,30* 256);
        sheet.setColumnWidth(21,4* 256);
        sheet.setColumnWidth(22,4* 256);
        sheet.setColumnWidth(23,4* 256);
        sheet.setColumnWidth(28,4* 256);
        sheet.setColumnWidth(31,4* 256);
        sheet.setColumnWidth(35,5* 256);
        sheet.setColumnWidth(38,5* 256);
        sheet.setColumnWidth(41,5* 256);
        sheet.setColumnWidth(44,4* 256);
        sheet.setColumnWidth(45,4* 256);
        sheet.setColumnWidth(47,4* 256);
        sheet.setColumnWidth(48,4* 256);
        sheet.setColumnWidth(53,4* 256);
        sheet.setColumnWidth(54,4* 256);
        sheet.setColumnWidth(55,28* 256);
        sheet.setColumnWidth(56,4* 256);
        sheet.setColumnWidth(58,4* 256);
        sheet.setColumnWidth(59,4* 256);

        sheet.setColumnWidth(61,4* 256);
        sheet.setColumnWidth(62,4* 256);
        sheet.setColumnWidth(63,4* 256);
        sheet.setColumnWidth(64,4* 256);
        sheet.setColumnWidth(65,4* 256);
        sheet.setColumnWidth(66,4* 256);
        sheet.setColumnWidth(67,4* 256);
        sheet.setColumnWidth(68,4* 256);
        sheet.setColumnWidth(69,4* 256);
        sheet.setColumnWidth(70,4* 256);
        sheet.setColumnWidth(71,4* 256);
        sheet.setColumnWidth(72,4* 256);
        sheet.setColumnWidth(73,4* 256);
        sheet.setColumnWidth(74,4* 256);
        sheet.setColumnWidth(75,4* 256);
        sheet.setColumnWidth(76,4* 256);
        sheet.setColumnWidth(77,4* 256);

    }

    private void setColumnDefaultStyleAndWidth(HSSFSheet sheet, HSSFCellStyle style) {
        sheet.setColumnWidth(0,20* 256);
        sheet.setColumnWidth(1,20* 256);
        sheet.setColumnWidth(2,15* 256);
        sheet.setColumnWidth(3,40* 256);
        sheet.setColumnWidth(4,15* 256);
        sheet.setColumnWidth(5,15* 256);
        sheet.setColumnWidth(6,15* 256);
        sheet.setColumnWidth(7,15* 256);
        sheet.setColumnWidth(8,20* 256);
        sheet.setColumnWidth(9,15* 256);
        sheet.setColumnWidth(10,30* 256);
        sheet.setColumnWidth(11,40* 256);
        sheet.setColumnWidth(12,30* 256);
        sheet.setColumnWidth(13,20* 256);
        sheet.setColumnWidth(14,15* 256);
        sheet.setColumnWidth(15,15* 256);
        sheet.setColumnWidth(16,15* 256);
        sheet.setColumnWidth(17,15* 256);
        sheet.setColumnWidth(18,15* 256);
        sheet.setColumnWidth(19,15* 256);
        sheet.setColumnWidth(20,15* 256);
        sheet.setColumnWidth(21,15* 256);
        sheet.setColumnWidth(22,15* 256);
        sheet.setColumnWidth(23,15* 256);
        sheet.setColumnWidth(24,40* 256);
        sheet.setColumnWidth(25,15* 256);
        sheet.setColumnWidth(26,15* 256);
        sheet.setColumnWidth(27,15* 256);
        sheet.setDefaultRowHeightInPoints(27);
        sheet.setDefaultColumnStyle(0, style);
        sheet.setDefaultColumnStyle(1, style);
        sheet.setDefaultColumnStyle(2, style);
        sheet.setDefaultColumnStyle(3, style);
        sheet.setDefaultColumnStyle(4, style);
        sheet.setDefaultColumnStyle(5, style);
        sheet.setDefaultColumnStyle(6, style);
        sheet.setDefaultColumnStyle(7, style);
        sheet.setDefaultColumnStyle(8, style);
        sheet.setDefaultColumnStyle(9, style);
        sheet.setDefaultColumnStyle(10, style);
        sheet.setDefaultColumnStyle(11, style);
        sheet.setDefaultColumnStyle(12, style);
        sheet.setDefaultColumnStyle(13, style);
        sheet.setDefaultColumnStyle(14, style);
        sheet.setDefaultColumnStyle(15, style);
        sheet.setDefaultColumnStyle(16, style);
        sheet.setDefaultColumnStyle(17, style);
        sheet.setDefaultColumnStyle(18, style);
        sheet.setDefaultColumnStyle(19, style);
        sheet.setDefaultColumnStyle(20, style);
        sheet.setDefaultColumnStyle(21, style);
        sheet.setDefaultColumnStyle(22, style);
        sheet.setDefaultColumnStyle(23, style);
        sheet.setDefaultColumnStyle(24, style);
        sheet.setDefaultColumnStyle(25, style);
        sheet.setDefaultColumnStyle(26, style);
        sheet.setDefaultColumnStyle(27, style);
        sheet.setDefaultColumnStyle(28, style);
        sheet.setDefaultColumnStyle(29, style);
    }

    /**
     * 设置边框
     */
    public void setRowBorder(HSSFWorkbook wb,HSSFCellStyle style,int row1,int row2 ,int col1,int col2 ){
        HSSFSheet sheet = wb.getSheetAt(0);
        for (int i = row1; i <= row2; i++) {
            HSSFRow row = sheet.getRow(i) == null ? sheet.createRow(i) : sheet.getRow(i);

            for (int j = col1; j <= col2; j++) {
                HSSFCell cell = row.getCell(j);
                if (null == cell) {
                    HSSFCell cell1 = row.createCell(j);
                    cell1.setCellStyle(style);
                }
            }
        }

    }

    private HSSFFont createFont(HSSFWorkbook wb, int fontSize, String fontName, Boolean bold) {
        HSSFFont font = wb.createFont();
        font.setFontHeightInPoints((short) fontSize);
        font.setFontName(fontName);
        font.setBold(bold);
        return font;
    }

    private HSSFCellStyle createStyle(HSSFWorkbook wb, HSSFFont font) {
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setWrapText(true);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        return cellStyle;
    }

    //导入模板
    @RequestMapping("/getEmpExcelTemplate")
    public void getEmpExcelTemplate(HttpServletResponse response) {
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("人员基本信息模板");

        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
        int tmp = 0;

        HSSFFont font11 = this.createFont(wb, 10, "宋体", false);
        HSSFCellStyle style12 = this.createStyle(wb, font11);
        this.setColumnDefaultStyleAndWidth(sheet, style12);
        HSSFRow row0 = sheet.createRow(tmp);
        //合并的单元格样式
        HSSFCellStyle boderStyle = wb.createCellStyle();
        //垂直居中
        boderStyle.setAlignment(HorizontalAlignment.CENTER);

        HSSFCellStyle headStyle = wb.createCellStyle();
        headStyle.cloneStyleFrom(cellStyle);
        HSSFFont hssfFont = wb.createFont();
        hssfFont.setColor(HSSFColor.RED.index);
        headStyle.setFont(hssfFont);
        sheet.setDefaultColumnWidth(25);
        sheet.createRow(0).createCell(0).setCellStyle(headStyle);
        sheet.createRow(1).createCell(0).setCellStyle(headStyle);
        sheet.getRow(1).getCell(0).setCellValue("");
        sheet.getRow(1).getCell(0).setCellValue("说明：此项为必填项");
        sheet.getRow(1).createCell(1).setCellStyle(headStyle);
        sheet.getRow(1).getCell(1).setCellValue("说明：此项为必填项");
        sheet.getRow(1).createCell(3).setCellStyle(headStyle);
        sheet.getRow(1).getCell(3).setCellValue("说明：此项为必填项 格式：2000-01-01");
        sheet.getRow(1).createCell(8).setCellStyle(headStyle);
        sheet.getRow(1).getCell(8).setCellValue("说明：此项为必填项");
        sheet.getRow(1).createCell(10).setCellStyle(headStyle);
        sheet.getRow(1).getCell(10).setCellValue("格式：2000-01-01");
        sheet.getRow(1).createCell(11).setCellStyle(headStyle);
        sheet.getRow(1).getCell(11).setCellValue("说明：此项为必填项");
        sheet.getRow(1).createCell(12).setCellStyle(headStyle);
        sheet.getRow(1).getCell(12).setCellValue("说明：此项为必填项");
        sheet.getRow(1).createCell(13).setCellStyle(headStyle);
        sheet.getRow(1).getCell(13).setCellValue("说明：此项为必填项");
        sheet.getRow(1).createCell(24).setCellStyle(headStyle);
        sheet.getRow(1).getCell(24).setCellValue("格式：2000-01-01");

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 27));
        HSSFRow rowTil = sheet.createRow(0);
        HSSFFont font = PoiUtils.createFont(wb, 16, "宋体", true, null);
        HSSFCellStyle tilStyle = PoiUtils.createStyle(wb, font, false);
        tilStyle.setAlignment(HorizontalAlignment.LEFT);
        PoiUtils.createCellWithStyleAndValue(rowTil,0,"新疆现代职业技术学院教职工花名册",tilStyle);

        sheet.addMergedRegion(new CellRangeAddress(2, 2, 5, 7));
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 25, 26));
        HSSFRow row1 = sheet.createRow(2);
        PoiUtils.createCellWithStyleAndValue(row1, 25, "职称", cellStyle);
        PoiUtils.createCellWithStyleAndValue(row1, 5, "职级", cellStyle);
        sheet.createRow(3).createCell(0).setCellStyle(cellStyle);
        HSSFRow row2 = sheet.getRow(3);
        sheet.getRow(3).getCell(0).setCellValue("姓名");
        sheet.getRow(3).createCell(1).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(1).setCellValue("部门");
        sheet.getRow(3).createCell(2).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(2).setCellValue("岗位");
        sheet.getRow(3).createCell(3).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(3).setCellValue("入职日期");
        sheet.getRow(3).createCell(4).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(4).setCellValue("婚姻状况");

        PoiUtils.createCellWithStyleAndValue(row2, 5, "级别", cellStyle);
        PoiUtils.createCellWithStyleAndValue(row2, 6, "职级文件号", cellStyle);
        PoiUtils.createCellWithStyleAndValue(row2, 7, "职级期限", cellStyle);

        sheet.getRow(3).createCell(8).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(8).setCellValue("性别");
        sheet.getRow(3).createCell(9).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(9).setCellValue("民族");
        sheet.getRow(3).createCell(10).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(10).setCellValue("出生日期");
        sheet.getRow(3).createCell(11).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(11).setCellValue("证件类型");
        sheet.getRow(3).createCell(12).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(12).setCellValue("证件号");
        sheet.getRow(3).createCell(13).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(13).setCellValue("联系方式");
        sheet.getRow(3).createCell(14).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(14).setCellValue("籍贯");
        sheet.getRow(3).createCell(15).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(15).setCellValue("户口所在地");
        sheet.getRow(3).createCell(16).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(16).setCellValue("户口所属地区");
        sheet.getRow(3).createCell(17).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(17).setCellValue("是否政审");
        sheet.getRow(3).createCell(18).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(18).setCellValue("现住址");
        sheet.getRow(3).createCell(19).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(19).setCellValue("政治面貌");
        sheet.getRow(3).createCell(20).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(20).setCellValue("文化程度");
        sheet.getRow(3).createCell(21).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(21).setCellValue("教育方式");
        sheet.getRow(3).createCell(22).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(22).setCellValue("毕业院校");
        sheet.getRow(3).createCell(23).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(23).setCellValue("专业");
        sheet.getRow(3).createCell(24).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(24).setCellValue("毕业时间");
        sheet.getRow(3).createCell(25).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(25).setCellValue("名称");
        sheet.getRow(3).createCell(26).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(26).setCellValue("职称级别");
        sheet.getRow(3).createCell(27).setCellStyle(cellStyle);
        sheet.getRow(3).getCell(27).setCellValue("备注");

        HSSFCellStyle textS = wb.createCellStyle();
        HSSFDataFormat form = wb.createDataFormat();
        textS.setDataFormat(form.getFormat("@"));
        for (int i = 4; i < 10000; i++) {
            HSSFRow row = sheet.createRow(i);
            for (int j = 0; j < 26; j++) {
                row.createCell(j).setCellStyle(textS);
            }
        }

        TableDict tableDict = new TableDict();
        tableDict.setText("dept_name");
        tableDict.setTableName("T_SYS_DEPT");
        tableDict.setWhere("  WHERE VALID_FLAG='1' ");
        List<String> list = commonService.getTableDictNameBy(tableDict);
        String[] strs5 = new String[list.size()];

        int end5 = list.size();
        for (int i = 0; i < end5; i++) {
            strs5[i] = list.get(i);
        }
        setHSSFValidation(sheet, strs5, 4, 65535, 1, 1);

        List<String> list1 = commonService.getSysDictName("GW", "");
        String[] gw = new String[list1.size()];
        for (int j = 0; j < list1.size(); j++) {
            gw[j] = list1.get(j);
        }

        setHSSFValidation(sheet, gw, 4, 65535, 2, 2);

        List<String> list2 = commonService.getSysDictName("HYZK", "");
        String[] hyzk = new String[list2.size()];
        for (int j = 0; j < list2.size(); j++) {
            hyzk[j] = list2.get(j);
        }
        setHSSFValidation(sheet, hyzk, 4, 65535, 4, 4);

        List<String> list3 = commonService.getSysDictName("ZJ", "");
        String[] zj = new String[list3.size()];
        for (int j = 0; j < list3.size(); j++) {
            zj[j] = list3.get(j);
        }
        setHSSFValidation(sheet, zj, 4, 65535, 5, 5);

        List<String> list4 = commonService.getSysDictName("XB", "");
        String[] xb = new String[list4.size()];
        for (int j = 0; j < list4.size(); j++) {
            xb[j] = list4.get(j);
        }
        setHSSFValidation(sheet, xb, 4, 65535, 8, 8);

        List<String> list5 = commonService.getSysDictName("MZ", "");
        String[] mz = new String[list5.size()];
        for (int j = 0; j < list5.size(); j++) {
            mz[j] = list5.get(j);
        }
        setHSSFValidation(sheet, mz, 4, 65535, 9, 9);

        List<String> list6 = commonService.getSysDictName("SFZJLX", "");
        String[] zjlx = new String[list6.size()];
        for (int j = 0; j < list6.size(); j++) {
            zjlx[j] = list6.get(j);
        }
        setHSSFValidation(sheet, zjlx, 4, 65535, 11, 11);

        TableDict tableDict1 = new TableDict();
        tableDict1.setText("NAME");
        tableDict1.setTableName("t_sys_administrative_divisions");
        tableDict1.setWhere("  WHERE VALID_FLAG='1' and type = '1'  ");
        List<String> list7 = commonService.getTableDictNameBy(tableDict1);
        String[] strs6 = new String[list7.size()];

        int end6 = list7.size();
        for (int i = 0; i < end6; i++) {
            strs6[i] = list7.get(i);
        }
        setHSSFValidation(sheet, strs6, 4, 65535, 14, 14);


        List<String> list8 = commonService.getSysDictName("HKSSDQ", "");
        String[] hk = new String[list8.size()];
        for (int j = 0; j < list8.size(); j++) {
            hk[j] = list8.get(j);
        }
        setHSSFValidation(sheet, hk, 4, 65535, 16, 16);


        List<String> list9 = commonService.getSysDictName("SFZS", "");
        String[] sfzs = new String[list9.size()];
        for (int j = 0; j < list9.size(); j++) {
            sfzs[j] = list9.get(j);
        }
        setHSSFValidation(sheet, sfzs, 4, 65535, 17, 17);


        List<String> list10 = commonService.getSysDictName("ZZMM", "");
        String[] zzmm = new String[list10.size()];
        for (int j = 0; j < list10.size(); j++) {
            zzmm[j] = list10.get(j);
        }
        setHSSFValidation(sheet, zzmm, 4, 65535, 19, 19);


        List<String> list11 = commonService.getSysDictName("WHCD", "");
        String[] whcd = new String[list11.size()];
        for (int j = 0; j < list11.size(); j++) {
            whcd[j] = list11.get(j);
        }
        setHSSFValidation(sheet, whcd, 4, 65535, 20, 20);


        List<String> list12 = commonService.getSysDictName("JYFS", "");
        String[] jyfs = new String[list12.size()];
        for (int j = 0; j < list12.size(); j++) {
            jyfs[j] = list12.get(j);
        }
        setHSSFValidation(sheet, jyfs, 4, 65535, 21, 21);


        List<String> list13 = commonService.getSysDictName("ZCJB", "");
        String[] zcjb = new String[list13.size()];
        for (int j = 0; j < list13.size(); j++) {
            zcjb[j] = list13.get(j);
        }
        setHSSFValidation(sheet, zcjb, 4, 65535, 26, 26);
        PoiUtils.outFile(wb, "人员基本信息模板", response);
    }

    private static void setDataValidation(HSSFSheet sheet, String strFormula, int firstRow, int endRow, int firstCol, int endCol) {
        CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        DVConstraint constraint = DVConstraint.createFormulaListConstraint(strFormula);//add
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);//add
        dataValidation.createErrorBox("Error", "Error");
        dataValidation.createPromptBox("", null);
        sheet.addValidationData(dataValidation);
    }

   /* public void getEmpExcelTemplate(HttpServletResponse response) {
        String rootPath = new File(getClass().getResource("/").getPath()).getParentFile().getParent().toString();
        rootPath = rootPath.replaceAll("%20", " ");
        String fileName = rootPath + "/template/empTemplate.xls";
        File file = FileUtils.getFile(fileName);
        OutputStream os = null;
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("人员基本信息模板.xls", "utf-8"));
            os = response.getOutputStream();
            os.write(FileUtils.readFileToByteArray(file));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }*/

    @ResponseBody
    @RequestMapping("/importEmp")
    public Message importEmp(@RequestParam(value = "file", required = false) CommonsMultipartFile file, String deptId) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Tree> depts = deptService.getDeptTree();
        TableDict tableDict = new TableDict();
        tableDict.setId("dept_id");
        tableDict.setText("dept_name");
        tableDict.setTableName(" T_SYS_DEPT ");
        tableDict.setWhere(" where VALID_FLAG='1' ");
        List<Select2> deptname = commonService.getTableDict(tableDict);
        List<Select2> sexs = commonService.getSysDict("XB", "");
        List<Select2> mzs = commonService.getSysDict("MZ", "");
        List<Select2> gangwei = commonService.getSysDict("GW", "");
        List<Select2> maritalStatus = commonService.getSysDict("HYZK", "");
        List<Select2> classPositions = commonService.getSysDict("ZJ", "");
        List<Select2> zjlx = commonService.getSysDict("SFZJLX", "");
        List<Select2> ssdq = commonService.getSysDict("HKSSDQ", "");
        List<Select2> examinePolitical = commonService.getSysDict("SFZS", "");
        List<Select2> politicalStatus = commonService.getSysDict("ZZMM", "");
        List<Select2> educationalLevel = commonService.getSysDict("WHCD", "");
        List<Select2> educationTechnique = commonService.getSysDict("JYFS", "");
        List<Select2> positionalLevel = commonService.getSysDict("ZCJB", "");
        TableDict tableDict1 = new TableDict();
        tableDict1.setId("ID");
        tableDict1.setText("NAME");
        tableDict1.setTableName("t_sys_administrative_divisions");
        tableDict1.setWhere("  WHERE VALID_FLAG='1' and type = '1'  ");
        List<Select2> list7 = commonService.getTableDict(tableDict1);

        List<Emp> emps = new ArrayList<Emp>();
        int count = 0;
        int num = 0;
        Object str;
        String msg = "第";
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (Exception e) {
            e.printStackTrace();
            ++num;
        }
        if (num > 0) {
            return new Message(1, "导入失败！请重新导入", null);
        } else {
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = getRealLastRowNum(workbook) + 2;
            for (int i = 4; i < end; i++) {
                HSSFRow row = sheet.getRow(i);
                int flag = 1;
                Emp emp = new Emp();
                emp.setStaffStatus("100");
                String idCard = CommonUtil.toIdcardCheck(PoiUtils.cellValue(row.getCell(12)));
                Emp e = empService.getEmpByIdCard(idCard);
                if (e == null) {
                    emp.setIdCard(idCard);
                } else {
                    emp = e;
                    flag = 0;
                }
                String name = CommonUtil.changeToString(row.getCell(0));
                emp.setName(name);

                String Dept = CommonUtil.changeToString(row.getCell(1));
                if (!"".equals(Dept)) {
                    for (Select2 dept : deptname) {
                        if (dept.getText().equals(Dept)) {
                            emp.setDeptId(dept.getId());
                            break;
                        }
                    }
                }

                String gw = CommonUtil.changeToString(row.getCell(2));
                if (!"".equals(gw)) {
                    for (Select2 jobs : gangwei) {
                        if (jobs.getText().equals(gw)) {
                            emp.setJob(jobs.getId());
                            break;
                        }
                    }
                }

                String time1 = CommonUtil.changeToString(row.getCell(3));
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                //必须捕获异常
                try {
                    java.util.Date Date = df.parse(time1);
                    java.sql.Date formatDate = new java.sql.Date(Date.getTime());
                    emp.setEntryDate(formatDate);
                } catch (ParseException px) {
                    px.printStackTrace();
                }

                String hyzk = CommonUtil.changeToString(row.getCell(4));
                if (!"".equals(hyzk)) {
                    for (Select2 hy : maritalStatus) {
                        if (hy.getText().equals(hyzk)) {
                            emp.setMaritalStatus(hy.getId());
                            break;
                        }
                    }
                }

                String zj = CommonUtil.changeToString(row.getCell(5));
                if (!"".equals(zj)) {
                    for (Select2 pl : classPositions) {
                        if (pl.getText().equals(zj)) {
                            emp.setClassPositions(pl.getId());
                            break;
                        }
                    }
                }

                emp.setFilenumber(PoiUtils.cellValue(row.getCell(6)));
                emp.setDeadline(PoiUtils.cellValue(row.getCell(7)));

                String Sex = CommonUtil.changeToString(row.getCell(8));
                if (!"".equals(Sex)) {
                    for (Select2 sex : sexs) {
                        if (sex.getText().equals(Sex)) {
                            emp.setSex(sex.getId());
                            break;
                        }
                    }
                }

                String nation = CommonUtil.changeToString(row.getCell(9));
                if (!"".equals(nation)) {
                    for (Select2 mz : mzs) {
                        if (mz.getText().equals(nation)) {
                            emp.setNation(mz.getId());
                            break;
                        }
                    }
                }

                String time = CommonUtil.changeToString(row.getCell(10));
                SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
                //必须捕获异常
                try {
                    java.util.Date Date = df1.parse(time);
                    java.sql.Date formatDate = new java.sql.Date(Date.getTime());
                    emp.setBirthday(formatDate);
                } catch (ParseException px) {
                    px.printStackTrace();
                }
                String idType = CommonUtil.changeToString(row.getCell(11));
                if (!"".equals(idType)) {
                    for (Select2 zjlx1 : zjlx) {
                        if (zjlx1.getText().equals(idType)) {
                            emp.setIdType(zjlx1.getId());
                            break;
                        }
                    }
                }


                String tel = CommonUtil.changeToString(row.getCell(13));
                emp.setTel(tel);

                String jg = CommonUtil.changeToString(row.getCell(14));
                if (!"".equals(jg)) {
                    for (Select2 jg1 : list7) {
                        if (jg1.getText().equals(jg)) {
                            emp.setNativePlaceProvince(jg1.getId());
                            break;
                        }
                    }
                }

                String hkszd = CommonUtil.changeToString(row.getCell(15));
                emp.setPermanentResidence(hkszd);

                String permanentResidenceLocal = CommonUtil.changeToString(row.getCell(16));
                if (!"".equals(permanentResidenceLocal)) {
                    for (Select2 permanentResidenceLocal1 : ssdq) {
                        if (permanentResidenceLocal1.getText().equals(permanentResidenceLocal)) {
                            emp.setPermanentResidenceLocal(permanentResidenceLocal1.getId());
                            break;
                        }
                    }
                }

                String sfzs = CommonUtil.changeToString(row.getCell(17));
                if (!"".equals(sfzs)) {
                    for (Select2 examinePolitical1 : examinePolitical) {
                        if (examinePolitical1.getText().equals(sfzs)) {
                            emp.setExaminePolitical(examinePolitical1.getId());
                            break;
                        }
                    }
                }

                String dz = CommonUtil.changeToString(row.getCell(18));
                emp.setAddress(dz);


                String zzmm = CommonUtil.changeToString(row.getCell(19));
                if (!"".equals(zzmm)) {
                    for (Select2 politicalStatus1 : politicalStatus) {
                        if (politicalStatus1.getText().equals(zzmm)) {
                            emp.setPoliticalStatus(politicalStatus1.getId());
                            break;
                        }
                    }
                }

                String whcd = CommonUtil.changeToString(row.getCell(20));
                if (!"".equals(whcd)) {
                    for (Select2 educationalLevel1 : educationalLevel) {
                        if (educationalLevel1.getText().equals(whcd)) {
                            emp.setEducationalLevel(educationalLevel1.getId());
                            break;
                        }
                    }
                }

                String jyfs = CommonUtil.changeToString(row.getCell(21));
                if (!"".equals(jyfs)) {
                    for (Select2 educationTechnique1 : educationTechnique) {
                        if (educationTechnique1.getText().equals(jyfs)) {
                            emp.setEducationTechnique(educationTechnique1.getId());
                            break;
                        }
                    }
                }

                String byyx = CommonUtil.changeToString(row.getCell(22));
                emp.setGraduateSchool(byyx);

                String zy = CommonUtil.changeToString(row.getCell(23));
                emp.setMajor(zy);

                String time2 = CommonUtil.changeToString(row.getCell(24));
                SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
                //必须捕获异常
                try {
                    java.util.Date Date = df2.parse(time2);
                    java.sql.Date formatDate = new java.sql.Date(Date.getTime());
                    emp.setGraduateTime(formatDate);
                } catch (ParseException px) {
                    px.printStackTrace();
                }


                String mc = CommonUtil.changeToString(row.getCell(25));
                emp.setPositionalTitles(mc);

                String zcjb = CommonUtil.changeToString(row.getCell(26));
                if (!"".equals(zcjb)) {
                    for (Select2 positionalLevel1 : positionalLevel) {
                        if (positionalLevel1.getText().equals(zcjb)) {
                            emp.setPositionalLevel(positionalLevel1.getId());
                            break;
                        }
                    }
                }

                String bz = CommonUtil.changeToString(row.getCell(27));
                emp.setRemark(bz);
                if (flag == 1) {
                    emp.setPersonId(CommonUtil.getUUID());
                    CommonUtil.save(emp);
                }else {
                    CommonUtil.update(emp);
                }
                EmpDeptRelation edr = new EmpDeptRelation();
                edr.setId(CommonUtil.getUUID());
                edr.setPersonId(emp.getPersonId());
                edr.setDeptId(emp.getDeptId());
                edr.setCreator(CommonUtil.getPersonId());
                edr.setCreateDept(CommonUtil.getDefaultDept());
                edr.setCreateTime(CommonUtil.getDate());

                LoginUser loginUser = new LoginUser();
                //String userAccount = emp.getName();
                String userAccount = null;
                try {
                    userAccount = PinyinHelper.convertToPinyinString(emp.getName(), "", PinyinFormat
                            .WITHOUT_TONE);
                } catch (PinyinException e1) {
                    flag = 0;
                }
                userAccount = CommonUtil.checkUserAccount(userAccount, loginUserService);
                //String tel = CommonUtil.changeToString(row.getCell(5));
                loginUser.setPhotoUrl(tel);
                loginUser.setId(CommonUtil.getUUID());
                loginUser.setUserAccount(userAccount);
                loginUser.setPersonId(emp.getPersonId());
                loginUser.setPassword((new SimpleHash("MD5", "123456", null, 1).toString()));
                loginUser.setUserType("0");
                loginUser.setDefaultDeptId(emp.getDeptId());
                loginUser.setCreateDept(CommonUtil.getDefaultDept());
                loginUser.setCreateTime(CommonUtil.getDate());
                loginUser.setCreator(CommonUtil.getPersonId());
                loginUser.setName(emp.getName());
                if (flag == 1) {
                    try {
                        empService.saveEmp(emp, edr, loginUser);
                    } catch (Exception e1) {
                        flag = 0;
                        e1.printStackTrace();
                    }
                }
                if (flag == 0) {
                    msg += i + ",";
                    count++;
                    empService.updateEmp(emp);
                }

            }
            if (count > 0) {
//                msg = msg.substring(0, msg.length() - 1) + "行,人员身份信息已存在！请重新导入！";
                msg = msg.substring(0, msg.length() - 1) + "行,人员身份信息已存在！已更新！";
            } else {
                msg = "导入成功！";
            }

            return new Message(1, msg, null);
        }
    }

    /**
     * 获取真实行数
     *
     * @param workbook 工作簿对象
     * @return 真实行数
     */
    private int getRealLastRowNum(Workbook workbook) {
        Sheet sheetAt = workbook.getSheetAt(0);
        int lastRowNum = sheetAt.getLastRowNum();

        Row row = sheetAt.getRow(0);
        int realLastRowNum = 0;
        error:
        for (int i = 2; i < lastRowNum; i++) {
            StringBuilder str = new StringBuilder();
            for (int j = 0; j < sheetAt.getRow(i).getPhysicalNumberOfCells(); j++) {
                Cell cell = sheetAt.getRow(i).getCell(j);
                try {
                    cell.setCellType(CellType.STRING);
                    str.append(cell.getStringCellValue());
                } catch (Exception e) {
                    break error;
                }

            }
            if (!"".equals(str.toString().replaceAll(" ", ""))) {
                realLastRowNum = realLastRowNum + 1;
            }
        }
        System.err.println("----------------------> 真实行数 " + realLastRowNum);
        return realLastRowNum;

    }

    @RequestMapping("/toImportEmp")
    public String toImportEmp() {
        return "/core/emp/importEmp";
    }

    @RequestMapping("/emp/toEditEmp")
    public ModelAndView editEmpBySelf() {
        LoginUser loginUser = CommonUtil.getLoginUser();
        ModelAndView mv = new ModelAndView("/core/emp/editEmp");
        String personId = loginUser.getPersonId();
        String deptId = loginUser.getDefaultDeptId();
        Emp emp = empService.getEmpByDeptIdAndPersonId(personId, deptId);
        mv.addObject("emp", emp);
        return mv;
    }

    @RequestMapping("/toViewEmpBySelf")
    public ModelAndView toViewEmpBySelf() {
        LoginUser loginUser = CommonUtil.getLoginUser();
        ModelAndView mv = new ModelAndView("/core/emp/viewEmpBySelf");
        Emp emp = empService.getEmpByDeptIdAndPersonId(loginUser.getPersonId(), loginUser.getDefaultDeptId());
        mv.addObject("emp", emp);
        mv.addObject("deptId", loginUser.getDefaultDeptId());
        return mv;
    }

    @ResponseBody
    @RequestMapping("/emp/deletedEmp")
    public ModelAndView deletedEmp() {
        ModelAndView mv = new ModelAndView("/core/emp/deletedEmp");
        return mv;
    }

    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping("/emp/getDeletedEmpList")
    public Map<String, Object> getDeletedEmpList(Emp emp, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> emps = new HashMap();
        emp.setCreateDept(CommonUtil.getDefaultDept());
        List<Emp> empList = empService.getDeletedEmpList(emp);
        PageInfo<List<Emp>> info = new PageInfo(empList);
        emps.put("draw", draw);
        emps.put("recordsTotal", info.getTotal());
        emps.put("recordsFiltered", info.getTotal());
        emps.put("data", empList);
        return emps;
    }

    @ResponseBody
    @RequestMapping("/emp/recoveryEmpById")
    public Message recoveryEmpById(String personId) {
        empService.recoveryEmp(personId);
        loginUserService.recoveryLoginUser(personId);
        return new Message(1, "恢复成功！", null);
    }

    @ResponseBody
    @RequestMapping("/emp/showDetailed")
    public ModelAndView showDetailed(String personId, String deptId) {
        ModelAndView mv = new ModelAndView("/core/emp/detailedEmp");
        Emp emp = empService.getEmpByDeptIdAndPersonId(personId, deptId);
        mv.addObject("emp", emp);
        return mv;
    }
}
