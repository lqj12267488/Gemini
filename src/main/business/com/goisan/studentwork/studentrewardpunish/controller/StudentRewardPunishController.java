package com.goisan.studentwork.studentrewardpunish.controller;

import com.goisan.studentwork.studentrewardpunish.bean.*;
import com.goisan.studentwork.studentrewardpunish.service.StudentRewardPunishService;
import com.goisan.system.bean.Role;
import com.goisan.system.bean.Student;
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
 * Created by wq on 2017/9/20.
 */
@Controller
public class StudentRewardPunishController {
    @Resource
    private StudentRewardPunishService studentRewardPunishService;

    @ResponseBody
    @RequestMapping("/studentRewardPunish/getStudentSexIdcard")
    public Map getStudentSexIdcard(String studentId) {
        Student student = studentRewardPunishService.getStudentSexIdcard(studentId);
        Map map = new HashMap();
        map.put("sexShow", student.getSexShow());
        map.put("sex", student.getSex());
        map.put("idcard", student.getIdcard());
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/getStudentCancelTime")
    public Map getStudentCancelTime(String punishingCycle, String punishTime) {
        if (("1").equals(punishingCycle)) {
            StudentPunish studentPunish = studentRewardPunishService.getStudentCancelTime(punishTime);
            Map map = new HashMap();
            map.put("cancelTime", studentPunish.getCancelTime());
            return map;
        } else {
            StudentPunish studentPunish1 = studentRewardPunishService.getStudentCancelTime1(punishTime);
            Map map = new HashMap();
            map.put("cancelTime", studentPunish1.getCancelTime());
            return map;
        }

    }

    //学校奖学金信息管理
    @RequestMapping("/studentRewardPunish/schoolBurse/list")
    public ModelAndView schoolBurseList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/schoolBurseList");
        return mv;
    }

    //学生奖惩个人查看
    @RequestMapping("/studentRewardPunish/personal")
    public ModelAndView studentRewardPunishPersonal() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/personalStudentRewardPunish");
        return mv;
    }

    //学生奖惩数据原
    @ResponseBody
    @RequestMapping("/studentRewardPunish/getPersonalStudentRewardPunishList")
    public Map<String, List<StudentPunish>> getPersonalStudentRewardPunishList(StudentPunish studentPunish) {
        String studentId = CommonUtil.getLoginUser().getPersonId();
        String studentName = CommonUtil.getLoginUser().getName();
        studentPunish.setStudentId(studentName);
        List<StudentPunish> studentPunishes = studentRewardPunishService.getRewardPunishCountList(studentPunish);
        Map<String, List<StudentPunish>> map = new HashMap<String, List<StudentPunish>>();
        map.put("data", studentPunishes);
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/schoolBurse/getList")
    public Map<String, List<SchoolBurse>> getSchoolBurseList(SchoolBurse schoolBurse) {
        Map<String, List<SchoolBurse>> map = new HashMap<String, List<SchoolBurse>>();
        String roleId = "";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                schoolBurse.setCreateDept(CommonUtil.getDefaultDept());
                schoolBurse.setCreator(CommonUtil.getPersonId());
            }
        }
        map.put("data", studentRewardPunishService.getSchoolBurseList(schoolBurse));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/schoolBurse/edit")
    public ModelAndView editSchooolBurse(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/schoolBurseEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            SchoolBurse schoolBurse = studentRewardPunishService.getSchoolBurseById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("schoolBurse", schoolBurse);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/schoolBurse/save")
    public Message saveSchoolBurse(SchoolBurse schoolBurse) {
        if (schoolBurse.getId() == "") {
            schoolBurse.setCreator(CommonUtil.getPersonId());
            schoolBurse.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertSchoolBurse(schoolBurse);
            return new Message(1, "新增成功！", null);
        } else {
            schoolBurse.setChanger(CommonUtil.getPersonId());
            schoolBurse.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateSchoolBurseById(schoolBurse);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/schoolBurse/detele")
    public Message deleteSchoolBurseById(String id) {
        studentRewardPunishService.deleteSchoolBurseById(id);
        return new Message(1, "删除成功！", null);
    }

    // 政府奖学金信息管理
    @RequestMapping("/studentRewardPunish/stateBurse/list")
    public ModelAndView stateBurseList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/stateBurseList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/stateBurse/getList")
    public Map<String, List<StateBurse>> getStateBurseList(StateBurse stateBurse) {
        Map<String, List<StateBurse>> map = new HashMap<String, List<StateBurse>>();
        String roleId = "";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                stateBurse.setDepartmentsId(CommonUtil.getDefaultDept());
                stateBurse.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }
        map.put("data", studentRewardPunishService.getStateBurseList(stateBurse));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/stateBurse/edit")
    public ModelAndView editStateBurse(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/stateBurseEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            StateBurse stateBurse = studentRewardPunishService.getStateBurseById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("stateBurse", stateBurse);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/stateBurse/save")
    public Message saveStateBurse(StateBurse stateBurse) {
        if (stateBurse.getId() == "") {
            stateBurse.setCreator(CommonUtil.getPersonId());
            stateBurse.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertStateBurse(stateBurse);
            return new Message(1, "新增成功！", null);
        } else {
            stateBurse.setChanger(CommonUtil.getPersonId());
            stateBurse.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateStateBurseById(stateBurse);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/stateBurse/detele")
    public Message deleteStateBurseById(String id) {
        studentRewardPunishService.deleteStateBurseById(id);
        return new Message(1, "删除成功！", null);
    }

    // 全日制奖学金信息管理
    @RequestMapping("/studentRewardPunish/fullBurse/list")
    public ModelAndView fullBurseList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/fullBurseList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/fullBurse/getList")
    public Map<String, List<FullBurse>> getFullBurseList(FullBurse fullBurse) {
        Map<String, List<FullBurse>> map = new HashMap<String, List<FullBurse>>();

        String roleId = "";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                fullBurse.setDepartmentsId(CommonUtil.getDefaultDept());
                fullBurse.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }
        map.put("data", studentRewardPunishService.getFullBurseList(fullBurse));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/fullBurse/edit")
    public ModelAndView editFullBurse(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/fullBurseEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            FullBurse fullBurse = studentRewardPunishService.getFullBurseById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("fullBurse", fullBurse);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/fullBurse/save")
    public Message saveFullBurse(FullBurse fullBurse) {
        if (fullBurse.getId() == "") {
            fullBurse.setCreator(CommonUtil.getPersonId());
            fullBurse.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertFullBurse(fullBurse);
            return new Message(1, "新增成功！", null);
        } else {
            fullBurse.setChanger(CommonUtil.getPersonId());
            fullBurse.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateFullBurseById(fullBurse);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/fullBurse/detele")
    public Message deleteFullBurseById(String id) {
        studentRewardPunishService.deleteFullBurseById(id);
        return new Message(1, "删除成功！", null);
    }

    // 免学费信息管理
    @RequestMapping("/studentRewardPunish/tuitionFree/list")
    public ModelAndView tuitionFreeList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/tuitionFreeList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/tuitionFree/getList")
    public Map<String, List<TuitionFree>> getTuitionFreeList(TuitionFree tuitionFree) {
        Map<String, List<TuitionFree>> map = new HashMap<String, List<TuitionFree>>();
        String roleId = "";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                tuitionFree.setDepartmentsId(CommonUtil.getDefaultDept());
                tuitionFree.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }

        map.put("data", studentRewardPunishService.getTuitionFreeList(tuitionFree));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/tuitionFree/edit")
    public ModelAndView editTuitionFree(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/tuitionFreeEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            TuitionFree tuitionFree = studentRewardPunishService.getTuitionFreeById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("tuitionFree", tuitionFree);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/tuitionFree/save")
    public Message saveTuitionFree(TuitionFree tuitionFree) {
        if (tuitionFree.getId() == "") {
            tuitionFree.setCreator(CommonUtil.getPersonId());
            tuitionFree.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertTuitionFree(tuitionFree);
            return new Message(1, "新增成功！", null);
        } else {
            tuitionFree.setChanger(CommonUtil.getPersonId());
            tuitionFree.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateTuitionFreeById(tuitionFree);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/tuitionFree/detele")
    public Message deleteTuitionFreeById(String id) {
        studentRewardPunishService.deleteTuitionFreeById(id);
        return new Message(1, "删除成功！", null);
    }

    // 学校助学金信息管理
    @RequestMapping("/studentRewardPunish/grants/list")
    public ModelAndView grantsList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/grantsList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/grants/getList")
    public Map<String, List<Grants>> getGrantsList(Grants grants) {
        Map<String, List<Grants>> map = new HashMap<String, List<Grants>>();
        map.put("data", studentRewardPunishService.getGrantsList(grants));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/grants/edit")
    public ModelAndView editG(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/grantsEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            Grants grants = studentRewardPunishService.getGrantsById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("grants", grants);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/grants/save")
    public Message saveGrants(Grants grants) {
        if (grants.getId() == "") {
            grants.setCreator(CommonUtil.getPersonId());
            grants.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertGrants(grants);
            return new Message(1, "新增成功！", null);
        } else {
            grants.setChanger(CommonUtil.getPersonId());
            grants.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateGrantsById(grants);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/grants/detele")
    public Message deleteGrantsById(String id) {
        studentRewardPunishService.deleteGrantsById(id);
        return new Message(1, "删除成功！", null);
    }

    // 助学贷款信息管理
    @RequestMapping("/studentRewardPunish/studentLoan/list")
    public ModelAndView studentLoanList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/studentLoanList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentLoan/getList")
    public Map<String, List<StudentLoan>> getStudentLoanList(StudentLoan studentLoan) {
        Map<String, List<StudentLoan>> map = new HashMap<String, List<StudentLoan>>();
        String roleId="";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                studentLoan.setDepartmentsId(CommonUtil.getDefaultDept());
                studentLoan.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }
        map.put("data", studentRewardPunishService.getStudentLoanList(studentLoan));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentLoan/edit")
    public ModelAndView editStudentLoan(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/studentLoanEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            StudentLoan studentLoan = studentRewardPunishService.getStudentLoanById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("studentLoan", studentLoan);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentLoan/save")
    public Message saveStudentLoan(StudentLoan studentLoan) {
        if (studentLoan.getId() == "") {
            studentLoan.setCreator(CommonUtil.getPersonId());
            studentLoan.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertStudentLoan(studentLoan);
            return new Message(1, "新增成功！", null);
        } else {
            studentLoan.setChanger(CommonUtil.getPersonId());
            studentLoan.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateStudentLoanById(studentLoan);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentLoan/detele")
    public Message deleteStudentLoanById(String id) {
        studentRewardPunishService.deleteStudentLoanById(id);
        return new Message(1, "删除成功！", null);
    }

    // 优秀学生干部信息管理
    @RequestMapping("/studentRewardPunish/studentCadres/list")
    public ModelAndView studentCadresList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/studentCadresList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentCadres/getList")
    public Map<String, List<StudentCadres>> getStudentCadresList(StudentCadres studentCadres) {
        Map<String, List<StudentCadres>> map = new HashMap<String, List<StudentCadres>>();
        String roleId="";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                studentCadres.setDepartmentsId(CommonUtil.getDefaultDept());
                studentCadres.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }
        map.put("data", studentRewardPunishService.getStudentCadresList(studentCadres));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentCadres/edit")
    public ModelAndView editStudentCadres(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/studentCadresEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            StudentCadres studentCadres = studentRewardPunishService.getStudentCadresById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("studentCadres", studentCadres);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentCadres/save")
    public Message saveStudentCadres(StudentCadres studentCadres) {
        if (studentCadres.getId() == "") {
            studentCadres.setCreator(CommonUtil.getPersonId());
            studentCadres.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertStudentCadres(studentCadres);
            return new Message(1, "新增成功！", null);
        } else {
            studentCadres.setChanger(CommonUtil.getPersonId());
            studentCadres.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateStudentCadresById(studentCadres);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentCadres/detele")
    public Message deleteStudentCadresById(String id) {
        studentRewardPunishService.deleteStudentCadresById(id);
        return new Message(1, "删除成功！", null);
    }

    // 市三好班级信息管理
    @RequestMapping("/studentRewardPunish/miyoshiClass/list")
    public ModelAndView miyoshiClassList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/miyoshiClassList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/miyoshiClass/getList")
    public Map<String, List<MiyoshiClass>> getMiyoshiClassList(MiyoshiClass miyoshiClass) {
        Map<String, List<MiyoshiClass>> map = new HashMap<String, List<MiyoshiClass>>();

        String roleId="";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                miyoshiClass.setDepartmentsId(CommonUtil.getDefaultDept());
                miyoshiClass.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }
        map.put("data", studentRewardPunishService.getMiyoshiClassList(miyoshiClass));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/miyoshiClass/edit")
    public ModelAndView editMiyoshiClass(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/miyoshiClassEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            MiyoshiClass miyoshiClass = studentRewardPunishService.getMiyoshiClassById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("miyoshiClass", miyoshiClass);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/miyoshiClass/save")
    public Message saveMiyoshiClass(MiyoshiClass miyoshiClass) {
        if (miyoshiClass.getId() == "") {
            miyoshiClass.setCreator(CommonUtil.getPersonId());
            miyoshiClass.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertMiyoshiClass(miyoshiClass);
            return new Message(1, "新增成功！", null);
        } else {
            miyoshiClass.setChanger(CommonUtil.getPersonId());
            miyoshiClass.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateMiyoshiClassById(miyoshiClass);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/miyoshiClass/detele")
    public Message deleteMiyoshiClassById(String id) {
        studentRewardPunishService.deleteMiyoshiClassById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/getHeadTeacherByClassId")
    public Map getHeadTeacherByClassId(String classId) {
        MiyoshiClass miyoshiClass = studentRewardPunishService.getHeadTeacherByClassId(classId);
        Map map = new HashMap();
        map.put("headTeacher", miyoshiClass.getHeadTeacher());
        map.put("headTeacherShow", miyoshiClass.getHeadTeacherShow());
        map.put("headTeacherDept", miyoshiClass.getHeadTeacherDept());
        map.put("headTeacherDeptShow", miyoshiClass.getHeadTeacherDeptShow());
        return map;
    }

    // 学生惩处信息维护
    @RequestMapping("/studentRewardPunish/studentPunish/list")
    public ModelAndView StudentPunishList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/studentPunishList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentPunish/getList")
    public Map<String, List<StudentPunish>> getStudentPunishList(StudentPunish studentPunish) {
        Map<String, List<StudentPunish>> map = new HashMap<String, List<StudentPunish>>();

        String roleId="";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                studentPunish.setDepartmentsId(CommonUtil.getDefaultDept());
                studentPunish.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }
        map.put("data", studentRewardPunishService.getStudentPunishList(studentPunish));
        return map;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentPunish/edit")
    public ModelAndView editStudentPunish(String id, String flag) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/studentPunishEdit");

        if (id == "" || id == null) {
            mv.addObject("head", "新增");
        } else {
            StudentPunish studentPunish = studentRewardPunishService.getStudentPunishById(id);
            if (flag != null) {
                if (flag.equals("1")) {
                    mv.addObject("head", "详情");
                }
            } else {
                mv.addObject("head", "修改");
            }
            mv.addObject("studentPunish", studentPunish);
            mv.addObject("flag", flag);
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentPunish/save")
    public Message saveStudentPunish(StudentPunish studentPunish) {
        if (studentPunish.getId() == "") {
            studentPunish.setCreator(CommonUtil.getPersonId());
            studentPunish.setCreateDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.insertStudentPunish(studentPunish);
            return new Message(1, "新增成功！", null);
        } else {
            studentPunish.setChanger(CommonUtil.getPersonId());
            studentPunish.setChangeDept(CommonUtil.getDefaultDept());
            studentRewardPunishService.updateStudentPunishById(studentPunish);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentPunish/detele")
    public Message deleteStudentPunishById(String id) {
        studentRewardPunishService.deleteStudentPunishById(id);
        return new Message(1, "删除成功！", null);
    }

    // 惩处学生信息查询
    @RequestMapping("/studentRewardPunish/studentPunish/select")
    public ModelAndView selectStudentPunishList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/selectStudentPunishList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/studentPunish/getSelectList")
    public Map<String, List<StudentPunish>> getSelectStudentPunishList(StudentPunish studentPunish) {
        Map<String, List<StudentPunish>> map = new HashMap<String, List<StudentPunish>>();
        String roleId="";
        if (CommonUtil.getUserRole().toArray().length > 1) {
            for (int i = 0; i < CommonUtil.getUserRole().toArray().length; i++) {
                roleId += "'" + CommonUtil.getUserRole().toArray()[i] + "',";
            }
            roleId = roleId.substring(0, roleId.length() - 1);
        } else if (CommonUtil.getUserRole().toArray().length == 1) {
            roleId = CommonUtil.getUserRole().toArray().toString();
        } else {
            roleId = "";
        }

        List<Role> list = studentRewardPunishService.getRoleByCurrentLogin(roleId);
        if (list.size() > 0) {

        } else {
            if ("001011".equals(CommonUtil.getDefaultDept())) {

            } else {
                studentPunish.setDepartmentsId(CommonUtil.getDefaultDept());
                studentPunish.setLevel(CommonUtil.getLoginUser().getLevel());
            }
        }
        map.put("data", studentRewardPunishService.getSelectStudentPunishList(studentPunish));
        return map;
    }

    //学生奖惩信息统计
    @RequestMapping("/studentRewardPunish/rewardpunishCount/list")
    public ModelAndView RewardPunishCountList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/studentrewardpunish/rewardpunishCount");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/studentRewardPunish/rewardpunishCount/getList")
    public Map<String, List<StudentPunish>> getRewardPunishCountList(StudentPunish studentPunish) {
        Map<String, List<StudentPunish>> map = new HashMap<String, List<StudentPunish>>();
        map.put("data", studentRewardPunishService.getRewardPunishCountList(studentPunish));
        return map;
    }
}
