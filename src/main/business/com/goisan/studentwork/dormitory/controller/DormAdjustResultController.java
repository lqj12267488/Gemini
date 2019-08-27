package com.goisan.studentwork.dormitory.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.studentwork.dormitory.bean.DormAdjustLog;
import com.goisan.studentwork.dormitory.bean.DormAdjustResult;
import com.goisan.studentwork.dormitory.bean.DormAway;
import com.goisan.studentwork.dormitory.service.DormAdjustResultService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by mcq on 2017/8/21.
 */
@Controller
public class DormAdjustResultController {
    @Resource
    private DormAdjustResultService dormAdjustResultService;

    //学生分寝
    @RequestMapping("/dorm/distribute")
    public String distributeList() {
        return "/business/studentwork/dormitory/distributeList";
    }

    //学生调寝
    @RequestMapping("/dorm/adjustment")
    public String adjustmentList() {
        return "/business/studentwork/dormitory/adjustmentList";
    }

    //学生退寝
    @RequestMapping("/dorm/back")
    public String backList() {
        return "/business/studentwork/dormitory/backList";
    }

    //学生旷寝
    @RequestMapping("/dorm/away")
    public String awayList() {
        return "/business/studentwork/dormitory/awayList";
    }

    //寝室入住统计
    @RequestMapping("/dorm/count")
    public String liveList() {
        return "/business/studentwork/dormitory/countList";
    }

    //学生分寝列表数据
    @ResponseBody
    @RequestMapping("/student/dorm/getDistributeList")
    public Map<String, Object> getDistributeList(Student student, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> students = new HashMap();
        student.setDepartmentsId(CommonUtil.getDefaultDept());
        student.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Student> list = dormAdjustResultService.getDistributeList(student);
        PageInfo<List<Student>> info = new PageInfo(list);
        students.put("draw", draw);
        students.put("recordsTotal", info.getTotal());
        students.put("recordsFiltered", info.getTotal());
        students.put("data", list);
        return students;
    }

    //学生分寝列表数据
    @ResponseBody
    @RequestMapping("/student/dorm/getAwayList")
    public Map getAwayList(DormAway dormAway, int draw, int start, int length) {
        if ("undefined".equals(dormAway.getClassId())) {
            dormAway.setClassId(null);
        }
        if ("undefined".equals(dormAway.getStudentName())) {
            dormAway.setStudentName(null);
        }
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> dormAways = new HashMap();
        dormAway.setCreateDept(CommonUtil.getDefaultDept());
        dormAway.setLevel(CommonUtil.getLoginUser().getLevel());
        List<DormAway> list = dormAdjustResultService.getAwayList(dormAway);
        PageInfo<List<DormAway>> info = new PageInfo(list);
        dormAways.put("draw", draw);
        dormAways.put("recordsTotal", info.getTotal());
        dormAways.put("recordsFiltered", info.getTotal());
        dormAways.put("data", list);
        return dormAways;
    }

    //分配寝室
    @RequestMapping("/dorm/toDistributeDorm")
    public String toDistributeDorm(String ids, String check_value, Model model) {
        int count = 0, start = 0;
        while ((start = ids.indexOf(",", start)) >= 0) {
            start += ",".length();
            count++;
        }
        //int count=ids.split(",").length;
        Student student = dormAdjustResultService.selectStudentByValue(check_value);
        String sex = student.getSex();
        model.addAttribute("head", "学生分寝");
        model.addAttribute("count", count);
        model.addAttribute("sex", sex);
        model.addAttribute("check_value", check_value);
        return "/business/studentwork/dormitory/toDistributeDorm";
    }

    //校验只能为同一性别的分寝
    @ResponseBody
    @RequestMapping("/dorm/checkDistributeDorm")
    public Message checkDistributeDorm(String check_value) {
        List<Student> studentList = dormAdjustResultService.getStudentByValue(check_value);
        if (studentList.size() > 1) {
            return new Message(1, "对不起,学生性别不统一", null);
        } else {

            return new Message(0, null, null);
        }
    }

    //保存分寝数据
    @ResponseBody
    @RequestMapping("/dorm/saveDormAdjustResult")
    public Message saveDormAdjustResult(String dormId, String check_value, String count) {
        dormAdjustResultService.saveDormAdjustResult(dormId, check_value, count);
        return new Message(0, "分寝成功", null);
    }


    //学生调寝列表数据
    @ResponseBody
    @RequestMapping("/student/dorm/getAdjustmentList")
    public Map<String, Object> getAdjustmentList(DormAdjustResult dormAdjustResult, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> dormAdjustResults = new HashMap();
        dormAdjustResult.setCreateDept(CommonUtil.getDefaultDept());
        dormAdjustResult.setLevel(CommonUtil.getLoginUser().getLevel());
        List<DormAdjustResult> list = dormAdjustResultService.getAdjustmentList(dormAdjustResult);
        PageInfo<List<DormAdjustResult>> info = new PageInfo(list);
        dormAdjustResults.put("draw", draw);
        dormAdjustResults.put("recordsTotal", info.getTotal());
        dormAdjustResults.put("recordsFiltered", info.getTotal());
        dormAdjustResults.put("data", list);
        return dormAdjustResults;
    }

    //查询剩余床位
    @ResponseBody
    @RequestMapping("/dorm/getDormOverPlusNumber")
    public String getDormOverPlusNumber(String dormId) {
        String overplus = dormAdjustResultService.getDormOverplusNumber(dormId);
        return overplus;
    }


    //调整寝室
    @RequestMapping("/dorm/toAdjustDorm")
    public String toAdjustDorm(String ids, String check_value, Model model) {
        Student student = dormAdjustResultService.selectStudentByValue(check_value.split(",")[0]);
        String sex = student.getSex();
        model.addAttribute("head", "学生调寝");
        model.addAttribute("sex", sex);
        model.addAttribute("id", ids.split(",")[0]);
        model.addAttribute("dormId", ids.split(",")[1]);
        return "/business/studentwork/dormitory/toAdjustDorm";
    }


    //保存调寝数据
    @ResponseBody
    @RequestMapping("/dorm/updateDormAdjustResult")
    public Message updateDormAdjustResult(String dormId, String id, String qsid) {
        dormAdjustResultService.updateDormAdjustResult(dormId, id, qsid);

        return new Message(0, "调寝成功", null);
    }

    //两人调寝
    @RequestMapping("/dorm/toDoublePeopleAdjust")
    public String toDoublePeopleAdjust(Model model) {
        model.addAttribute("head", "两人调寝");
        return "/business/studentwork/dormitory/toDoublePeopleAdjust";
    }

    //学生自动完成框(学生姓名--班级--寝室)
    @ResponseBody
    @RequestMapping("/dorm/student/autoCompleteStudentClassDorm")
    public List<AutoComplete> autoCompleteStudentClassDorm() {
        return dormAdjustResultService.autoCompleteStudentClassDorm();
    }

    //两人调寝保存
    @ResponseBody
    @RequestMapping("/dorm/saveDoublePerpleAdjust")
    public Message saveDoublePerpleAdjust(String firstStudent, String firstClass, String firstDorm, String secondStudent, String secondClass, String secondDorm) {
        dormAdjustResultService.saveDoublePerpleAdjust(firstStudent, firstClass, firstDorm, secondStudent, secondClass, secondDorm);
        return new Message(0, "两人互调成功", null);
    }

    //两寝互调
    @RequestMapping("/dorm/toDoubleDormAdjust")
    public String toDoubleDormAdjust(Model model) {
        model.addAttribute("head", "两寝互调");
        return "/business/studentwork/dormitory/toDoubleDormAdjust";
    }

    @RequestMapping("/student/dorm/away/toAdd")
    public String addAwayDorm(Model model) {
        model.addAttribute("head", "新增旷寝");
        return "/business/studentwork/dormitory/addAwayDorm";
    }

    //校验两寝互调
    @ResponseBody
    @RequestMapping("/dorm/checkDoubleDormAdjust")
    public Message checkDoubleDormAdjust(String firstDorm, String secondDorm, String firstMemberId, String secondMemberId) {
        String firstRoomType = dormAdjustResultService.getDormType(firstDorm);
        String secondRoomType = dormAdjustResultService.getDormType(secondDorm);
        if (firstRoomType.equals(secondRoomType)) {
            String firstDormName = dormAdjustResultService.getDormName(firstDorm);
            String secondDormName = dormAdjustResultService.getDormName(secondDorm);
            String firstOver = dormAdjustResultService.getDormOverplusNumber(firstDorm);
            String secondOver = dormAdjustResultService.getDormOverplusNumber(secondDorm);
            int firstOverNumber = Integer.parseInt(firstOver);
            int secondOverNumber = Integer.parseInt(secondOver);
            //选中的
            int firstMemberNumber = firstMemberId.split(",").length;
            int secondMemberNumber = secondMemberId.split(",").length;
            int firstAll = firstOverNumber + firstMemberNumber;
            int secondAll = secondOverNumber + secondMemberNumber;
            if (firstMemberNumber > secondAll) {
                return new Message(2, "超出" + secondDormName + "可容纳数量", null);
            }
            if (secondMemberNumber > firstAll) {
                return new Message(3, "超出" + firstDormName + "可容纳数量", null);
            }
        } else {
            return new Message(1, "对不起,寝室类型不匹配", null);
        }
        return new Message(0, null, null);
    }


    //两寝调寝保存
    @ResponseBody
    @RequestMapping("/dorm/saveDoubleDormAdjust")
    public Message saveDoubleDormAdjust(String firstDorm, String secondDorm, String firstMemberId, String secondMemberId) {
        dormAdjustResultService.saveDoubleDormAdjust(firstDorm, secondDorm, firstMemberId, secondMemberId);
        return new Message(0, "两寝互调成功", null);

    }

    //退寝
    @RequestMapping("/dorm/toBackDorm")
    public String toBackDorm(String ids, String check_value, Model model) {
        model.addAttribute("head", "学生退寝");
        model.addAttribute("ids", ids);
        model.addAttribute("check_value", check_value);
        return "/business/studentwork/dormitory/toBackDorm";
    }


    //保存退寝
    @ResponseBody
    @RequestMapping("/dorm/saveBackDorm")
    public Message saveBackDorm(String ids, String check_value, String backType, String backTypeText) {
        dormAdjustResultService.saveBackDorm(ids, check_value, backType, backTypeText);
        return new Message(0, "退寝成功", null);

    }

    //查看操作日志
    @ResponseBody
    @RequestMapping("/dorm/searchLog")
    public ModelAndView searchLog(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/dormitory/searchLog");
        mv.addObject("head", "操作日志");
        mv.addObject("id", id);
        return mv;
    }

    //入住日志数据源
    @ResponseBody
    @RequestMapping("/dorm/getLogList")
    public Map getLogList(String id) {
        return CommonUtil.tableMap(dormAdjustResultService.getLogList(id));
    }

    //学生自动完成框(学生姓名--根据班级联动)
    @ResponseBody
    @RequestMapping("/dorm/student/away/autoCompleteStudentByAway")
    public List<AutoComplete> autoCompleteStudentByAway(String classId) {
        List<AutoComplete> list = dormAdjustResultService.autoCompleteStudentByAway(classId);
        return list;
    }

    //新增旷寝
    @ResponseBody
    @RequestMapping("/dorm/student/away/saveAwayDorm")
    public Message saveAwayDorm(DormAway dormAway) {
        CommonUtil.save(dormAway);
        dormAdjustResultService.saveAwayDorm(dormAway);
        return new Message(0, "保存成功", null);

    }

}
