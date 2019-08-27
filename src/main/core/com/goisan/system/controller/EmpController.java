package com.goisan.system.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.stuxuhai.jpinyin.PinyinException;
import com.github.stuxuhai.jpinyin.PinyinFormat;
import com.github.stuxuhai.jpinyin.PinyinHelper;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.system.bean.*;
import com.goisan.system.service.*;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public Message saveEmp(Emp emp, String img) {
        String root = new File(getClass().getResource("/").getPath()).getParentFile().getParentFile().getPath();
        CommonUtil.generateImage(img, root + File.separator + "idcardimg" + File.separator + emp.getIdCard() + ".jpeg");
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

            String personId = CommonUtil.getUUID();
            empnew.setPersonId(personId);
            empnew.setCreator(CommonUtil.getPersonId());
//        empnew.setCreateTime(CommonUtil.getDate());
            empnew.setCreateDept(CommonUtil.getDefaultDept());
            empnew.setValidFlag("1");
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
            loginUser.setIdCardPhotoUrl(File.separator + "idcardimg" + File.separator + emp.getIdCard() + ".jpeg");
            List<Emp> list = empService.getEmpStaffId(empnew.getStaffId());
            if(list.size()>0){
                message.setStatus(0);
                message.setMsg("教职工编号重复！");
            }else{
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
    public Message updateEmp(Emp emp) {
        emp.setChanger(CommonUtil.getPersonId());
        emp.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
        List<Emp> list = empService.getEmpStaffId(emp.getStaffId());
        if(list.size()>1){
            return new Message(0, "教职工编号重复！", null);
        }else{
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
    public Map<String, Object> getEmpRangeList(EmpRange empRange,int draw, int start, int length) {
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
        return mv;

    }
    @ResponseBody
    @RequestMapping("/toAssignRoles")
    public ModelAndView toAssignRoles(String personIds, String deptId) {
        List<Tree> roles = empService.getRoleList();
        List<String> empRoles = empService.getEmpRole(personIds.substring(0,personIds.length()-2), deptId);
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
        mv.addObject("personId", personIds.replaceAll("'",""));
        mv.addObject("deptId", deptId);
        return mv;

    }

    @ResponseBody
    @RequestMapping("/changeEmpRole")
    public Message changeEmpRole(String ids, String personId, String deptId) {
        empService.changeEmpRole(ids, personId, deptId);
        return new Message(1, "分配成功！", null);
    }

    @RequestMapping("/exportEmp")
    public void exportEmp(Emp emp1, HttpServletResponse response) {
        List<Emp> emps;
        if ("undefined".equals(emp1.getDeptId())) {
            emps = empService.getEmpList(null);
        } else {
            emps = empService.getEmpList(emp1);
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //创建HSSFWorkbook对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //创建HSSFSheet对象
        HSSFSheet sheet = wb.createSheet("sheet0");
        //创建HSSFRow对象
        HSSFRow hssfRow = sheet.createRow(0);
        hssfRow.createCell(0).setCellValue("姓名");
        hssfRow.createCell(1).setCellValue("身份证号");
        hssfRow.createCell(2).setCellValue("部门");
        hssfRow.createCell(3).setCellValue("电话");
        hssfRow.createCell(4).setCellValue("性别");
        hssfRow.createCell(5).setCellValue("民族");
        hssfRow.createCell(6).setCellValue("地址");
        hssfRow.createCell(7).setCellValue("出生日期");
        int tmp = 1;
        for (Emp emp : emps) {
            HSSFRow row = sheet.createRow(tmp);
            //创建HSSFCell对象
            row.createCell(0).setCellValue(emp.getName());
            row.createCell(1).setCellValue(emp.getIdCard());
            row.createCell(2).setCellValue(emp.getDeptName());
            row.createCell(3).setCellValue(emp.getTel());
            row.createCell(4).setCellValue(emp.getSexShow());
            row.createCell(5).setCellValue(emp.getNationShow());
            row.createCell(6).setCellValue(emp.getAddress());
            if (emp.getBirthday() != null) {
                row.createCell(7).setCellValue(sdf.format(emp.getBirthday()));
            }
            tmp++;
        }
        OutputStream os = null;
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode
                    ("人员基本信息.xls", "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.flush();
                os.close();
                wb.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    @RequestMapping("/getEmpExcelTemplate")
    public void getEmpExcelTemplate(HttpServletResponse response) {
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
    }

    @ResponseBody
    @RequestMapping("/importEmp")
    public Message importEmp(@RequestParam(value = "file", required = false) CommonsMultipartFile file, String deptId) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Tree> depts = deptService.getDeptTree();
        List<Select2> sexs = commonService.getSysDict("XB", "");
        List<Select2> mzs = commonService.getSysDict("MZ", "");
        List<Emp> emps = new ArrayList<Emp>();
        int count = 0;
        int num = 0;
        Object str;
        String msg = "第";
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
            ++num;
        }
        if (num > 0) {
            return new Message(1, "导入失败！请重新导入", null);
        } else {
            HSSFSheet sheet = workbook.getSheetAt(0);
            int end = sheet.getLastRowNum();
            for (int i = 2; i <= end; i++) {
                HSSFRow row = sheet.getRow(i);
                int flag = 1;
                Emp emp = new Emp();
                emp.setPersonId(CommonUtil.getUUID());
                emp.setStaffStatus("100");
                emp.setName(row.getCell(0).toString());
                String idCard = CommonUtil.toIdcardCheck(row.getCell(1).toString());

                Emp e = empService.getEmpByIdCard( idCard );
                if (e == null) {
                    emp.setIdCard(idCard);
                } else {
                    flag = 0;
                }
//                String deptName = CommonUtil.changeToString(row.getCell(2));
                emp.setDeptId(deptId);
                String Sex = CommonUtil.changeToString(row.getCell(2));
                if (!"".equals(Sex)) {
                    for (Select2 sex : sexs) {
                        if (sex.getText().equals(Sex)) {
                            emp.setSex(sex.getId());
                            break;
                        }
                    }
                }
                emp.setAddress(CommonUtil.changeToString(row.getCell(3)));
                String nation = CommonUtil.changeToString(row.getCell(4));
                if (!"".equals(nation)) {
                    for (Select2 mz : mzs) {
                        if (mz.getText().equals(nation)) {
                            emp.setNation(mz.getId());
                            break;
                        }
                    }
                }
                emp.setTel(CommonUtil.changeToString(row.getCell(5)));
                String time = CommonUtil.changeToString(row.getCell(6));
                if (!"".equals(time)) {
                    try {
                        emp.setBirthday(CommonUtil.formatExcelDate(time));
                    } catch (ParseException e1) {
                        flag = 0;
                        e1.printStackTrace();
                    }
                }
                emp.setCreator(CommonUtil.getPersonId());
                emp.setCreateDept(CommonUtil.getDefaultDept());
                emp.setCreateTime(CommonUtil.getDate());
                emp.setValidFlag("1");
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
                String tel = CommonUtil.changeToString(row.getCell(5));
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
                }

            }
            if (count > 0) {
                msg = msg.substring(0, msg.length() - 1) + "行,人员身份信息不正确！请重新导入！";
            } else {
                msg = "导入成功！";
            }

            return new Message(1, msg, null);
        }
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
    public Map<String, Object> getDeletedEmpList(Emp emp,int draw, int start, int length) {
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
