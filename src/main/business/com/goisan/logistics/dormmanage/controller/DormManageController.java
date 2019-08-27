package com.goisan.logistics.dormmanage.controller;

import com.goisan.logistics.dormmanage.bean.DormManage;
import com.goisan.logistics.dormmanage.bean.StudentDorm;
import com.goisan.logistics.dormmanage.bean.StudentPlanJob;
import com.goisan.logistics.dormmanage.bean.TeacherPlanJob;
import com.goisan.logistics.dormmanage.service.DormManageService;
import com.goisan.system.bean.Select2;
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
public class DormManageController {
    @Resource
    private DormManageService dormManageService;
/*    @ResponseBody
    @RequestMapping("/studentRewardPunish/getStudentSexIdcard")
    public Map getStudentSexIdcard(String studentId){
        Student student= studentRewardPunishService.getStudentSexIdcard(studentId);
        Map map=new HashMap();
        map.put("sexShow",student.getSexShow());
        map.put("sex",student.getSex());
        map.put("idcard",student.getIdcard());
        return map;
    }*/
    //学生宿委会人员管理跳转页
    @RequestMapping("/dormmanage/studentDormList/skip")
    public ModelAndView studentBurseList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/studentDormList");
        return mv;
    }
    //页面数据源
    @ResponseBody
    @RequestMapping("/dormmanage/studentDormList")
    public Map<String,List<StudentDorm>> getstudentDormList(StudentDorm studentDorm){
        String create = CommonUtil.getPersonId();
        studentDorm.setCreator(create);
        List<StudentDorm> list=dormManageService.getStudentDormList(studentDorm);
        Map<String,List<StudentDorm>> map=new HashMap<String, List<StudentDorm>>();
        map.put("data", list);
        return map;
    }
     //新增学生
    @ResponseBody
    @RequestMapping("/dormmanage/studentDormList/edit")
    public ModelAndView editStudentDorm(String id,String flag){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/studentDormEdit");

        if(id==""||id==null){
            mv.addObject("head","新增");
        }else{
          /*  SchoolBurse schoolBurse = dormManageService.getSchoolBurseById(id);*/
            if(flag!=null){
                if(flag.equals("1")){
                    mv.addObject("head", "详情");
                }
            }else {
                mv.addObject("head", "修改");
            }
           /* mv.addObject("schoolBurse", schoolBurse);*/
            mv.addObject("flag", flag);
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/dormmanage/studentdorm/save")
    public Message saveStudentDorm(StudentDorm studentDorm){
        String studentId = studentDorm.getStudentId();
        Student student = dormManageService.getStudentSexIdcardName(studentId);
        String studentName = student.getName();
        studentDorm.setStudentName(studentName);
        if(studentDorm.getStudentDormId()==""||studentDorm.getStudentDormId()==null){
            studentDorm.setCreator(CommonUtil.getPersonId());
            studentDorm.setCreateDept(CommonUtil.getDefaultDept());
            dormManageService.insertStudentDorm(studentDorm);
            return new Message(1,"新增成功！",null);
        }else{
            studentDorm.setChanger(CommonUtil.getPersonId());
            studentDorm.setChangeDept(CommonUtil.getDefaultDept());
            dormManageService.updateStudentDormById(studentDorm);
            return new Message(1,"修改成功！",null);
        }
    }

    @ResponseBody
    @RequestMapping("/dormmanage/getStudentDormById")
    public ModelAndView getStudentDormById(StudentDorm studentDorm){
        StudentDorm studentDorm1 = dormManageService.getStudentDormById(studentDorm);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改");
        mv.addObject("studentDorm", studentDorm1);
        mv.setViewName("/business/logistics/dormmanage/studentDormEdit");
        return mv;
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/dormmanage/studentdorm/delete")
    public Message deleteStudentDorm(StudentDorm studentDorm){
        dormManageService.deleteStudentDormById(studentDorm);
        return new Message(1,"删除成功！",null);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////
    //宿委会人员日志菜单
    //学生宿委会人员管理跳转页
    @RequestMapping("/dormmanage/studentDormListLog/skip")
    public ModelAndView schoolBurseListLog(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/studentDormListLog");
        return mv;
    }
    //页面数据源
    @ResponseBody
    @RequestMapping("/dormmanage/studentDormListLog")
    public Map<String,List<StudentDorm>> getstudentDormListLog(StudentDorm studentDorm){
        String create = CommonUtil.getPersonId();
        studentDorm.setCreator(create);
        List<StudentDorm> list=dormManageService.getStudentDormListLog(studentDorm);
        Map<String,List<StudentDorm>> map=new HashMap<String, List<StudentDorm>>();
        map.put("data", list);
        return map;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////
    //学生排班菜单
    //学生排班菜单页面跳转
    @RequestMapping("/dormmanage/studentPlanJob/skip")
    public ModelAndView studentPlanJobList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/studentPlanJobList");
        return mv;
    }
    //页面数据源
    @ResponseBody
    @RequestMapping("/dormmanage/studentPlanJobList")
    public Map<String,List<StudentDorm>> getstudentPlanJobList(StudentPlanJob studentPlanJob){
        String create = CommonUtil.getPersonId();
        studentPlanJob.setCreator(create);
        List<StudentDorm> list=dormManageService.getStudentPlanJobList(studentPlanJob);
        Map<String,List<StudentDorm>> map=new HashMap<String, List<StudentDorm>>();
        map.put("data", list);
        return map;
    }
    //新增、修改页面跳转
    @ResponseBody
    @RequestMapping("/dormmanage/studentPlanJob/edit")
    public ModelAndView editStudentPlanJob(String id,String flag){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/editStudentPlanJob");
        if(id==""||id==null){
            mv.addObject("head","新增");
        }else{
            mv.addObject("head", "修改");
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/dormmanage/getStudentPlanJobById")
    public ModelAndView getStudentPlanJobById(StudentPlanJob studentPlanJob){
        StudentPlanJob studentPlanJob1 = dormManageService.getStudentPlanJobById(studentPlanJob);
        ModelAndView mv = new ModelAndView();
        String personId = CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        studentPlanJob.setChanger(personId);
        studentPlanJob.setChangeDept(personId);
        mv.addObject("head", "修改");
        mv.addObject("studentPlanJob", studentPlanJob1);
        mv.setViewName("/business/logistics/dormmanage/editStudentPlanJob");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/dormmanage/studentPlanJob/save")
    public Message saveStudentPlanJob(StudentPlanJob studentPlanJob){
/*        String studentId = studentDorm.getStudentId();
        Student student = dormManageService.getStudentSexIdcardName(studentId);
        String studentName = student.getName();
        studentDorm.setStudentName(studentName);*/

        if(studentPlanJob.getStudentOrderId()==""||studentPlanJob.getStudentOrderId()==null){
            studentPlanJob.setCreator(CommonUtil.getPersonId());
            studentPlanJob.setCreateDept(CommonUtil.getDefaultDept());
            dormManageService.insertStudentPlanJob(studentPlanJob);
            return new Message(1,"新增成功！",null);
        }else{
            studentPlanJob.setChanger(CommonUtil.getPersonId());
            studentPlanJob.setChangeDept(CommonUtil.getDefaultDept());
            dormManageService.updateStudentPlanJobById(studentPlanJob);
            return new Message(1,"修改成功！",null);
        }
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/dormmanage/studentPlanJob/delete")
    public Message deleteStudentPlanJob(StudentPlanJob studentPlanJob){
        dormManageService.deleteStudentPlanJobById(studentPlanJob);
        return new Message(1,"删除成功！",null);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    //老师宿管人员维护菜单
    //老师宿管人员维护菜单页面跳转
    @RequestMapping("/dormmanage/teacherDormList/skip")
    public ModelAndView teacherDormSkip(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/teacherPlanJobList");
        return mv;
    }
    //页面数据源
    @ResponseBody
    @RequestMapping("/dormmanage/teacherPlanJobList")
    public Map<String,List<TeacherPlanJob>> getTeacherPlanJobList(TeacherPlanJob teacherPlanJob){
        String create = CommonUtil.getPersonId();
        teacherPlanJob.setCreator(create);
            List<TeacherPlanJob> list=dormManageService.getTeacherPlanJobList(teacherPlanJob);
        Map<String,List<TeacherPlanJob>> map=new HashMap<String, List<TeacherPlanJob>>();
        map.put("data", list);
        return map;
    }
    @RequestMapping("/dormmanage/teacherPlanJob/edit")
    public ModelAndView editTeacherPlanJob(String id){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/editTeacherPlanJob");
        if(id==""||id==null){
            mv.addObject("head","新增");
        }else{
            mv.addObject("head", "修改");
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/dormmanage/teacherPlanJob/save")
    public Message saveTeacherPlanJob(TeacherPlanJob teacherPlanJob){
        if(teacherPlanJob.getTeacherOrderId()==""||teacherPlanJob.getTeacherOrderId()==null){
            teacherPlanJob.setCreator(CommonUtil.getPersonId());
            teacherPlanJob.setCreateDept(CommonUtil.getDefaultDept());
            dormManageService.insertTeacherPlanJob(teacherPlanJob);
            return new Message(1,"新增成功！",null);
        }else{
            teacherPlanJob.setChanger(CommonUtil.getPersonId());
            teacherPlanJob.setChangeDept(CommonUtil.getDefaultDept());
            dormManageService.updateTeacherPlanJobById(teacherPlanJob);
            return new Message(1,"修改成功！",null);
        }
    }
    @ResponseBody
    @RequestMapping("/dormmanage/teacherPlanJob/shiftShiftById")
    public Message shiftShiftById(TeacherPlanJob teacherPlanJob){
            dormManageService.shiftShiftById(teacherPlanJob);
            return new Message(1,"交班成功！",null);

    }
    @ResponseBody
    @RequestMapping("/dormmanage/getTeacherPlanJobById")
    public ModelAndView getTeacherPlanJobById(TeacherPlanJob teacherPlanJob){
        TeacherPlanJob teacherPlanJob1 = dormManageService.getTeacherPlanJobById(teacherPlanJob);
        ModelAndView mv = new ModelAndView();
        String personId = CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        teacherPlanJob.setChanger(personId);
        teacherPlanJob.setChangeDept(personId);
        mv.addObject("head", "修改");
        mv.addObject("teacherPlanJob", teacherPlanJob1);
        mv.setViewName("/business/logistics/dormmanage/editTeacherPlanJob");
        return mv;
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/dormmanage/teacherPlanJob/delete")
    public Message deleteTeacherPlanJob(TeacherPlanJob teacherPlanJob){
        dormManageService.deleteTeacherPlanJobById(teacherPlanJob);
        return new Message(1,"删除成功！",null);
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //寝室管理菜单
    @RequestMapping("/dormmanage/skip")
    public ModelAndView DormManageSkip(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/dormManageList");
        String persong_id = CommonUtil.getPersonId();
        mv.addObject("person_id",persong_id);
        return mv;
    }
    //寝室管理菜单
    @RequestMapping("/dormmanage/skipc")
    public ModelAndView DormManageSkipc(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/logistics/dormmanage/dormManagecList");
        String persong_id = CommonUtil.getPersonId();
        mv.addObject("person_id",persong_id);
        return mv;
    }
    //页面数据源
    @ResponseBody
    @RequestMapping("/dormmanage/DormManageList")
    public Map<String,List<DormManage>> getDormManageList(DormManage dormManage,String type){
        String create = CommonUtil.getPersonId();
        dormManage.setCreator(create);
        List<DormManage> list=dormManageService.getDormManageList(dormManage);
        Map<String,List<DormManage>> map=new HashMap<String, List<DormManage>>();
        map.put("data", list);
        return map;
    }
    @RequestMapping("/dormmanage/edit")
    public ModelAndView editDormManage(String manageId){
        ModelAndView mv=new ModelAndView();
        String persong_id = CommonUtil.getPersonId();
        mv.setViewName("/business/logistics/dormmanage/editDormManage");
        mv.addObject("person_id",persong_id);
        DormManage dormManage = new DormManage();
        dormManage.setManageId(manageId);
        DormManage dormManage1 = dormManageService.getDormManageById(dormManage);
        mv.addObject("DormManage",dormManage1);
        if(manageId==""||manageId==null){
            mv.addObject("head","新增");
        }else{
            mv.addObject("head", "修改");
        }
        return mv;
    }


    @RequestMapping("/dormmanage/editc")
    public ModelAndView editDormManagec(String manageId){
        ModelAndView mv=new ModelAndView();
        String persong_id = CommonUtil.getPersonId();
        mv.setViewName("/business/logistics/dormmanage/editDormcManage");
        mv.addObject("person_id",persong_id);
        DormManage dormManage = new DormManage();
        dormManage.setManageId(manageId);
        DormManage dormManage1 = dormManageService.getDormManageById(dormManage);
        mv.addObject("DormManage",dormManage1);
        if(manageId==""||manageId==null){
            mv.addObject("head","新增");
        }else{
            mv.addObject("head", "修改");
        }
        return mv;
    }
    @ResponseBody
    @RequestMapping("/dormmanage/save")
    public Message saveDormManage(DormManage dormManage){
        if(dormManage.getManageId()==""||dormManage.getManageId()==null){
            dormManage.setCreator(CommonUtil.getPersonId());
            dormManage.setCreateDept(CommonUtil.getDefaultDept());
            dormManage.setTeacherId(CommonUtil.getPersonId());
            dormManageService.insertDormManage(dormManage);
            return new Message(1,"新增成功！",null);
        }else{
            dormManage.setChanger(CommonUtil.getPersonId());
            dormManage.setChangeDept(CommonUtil.getDefaultDept());
            dormManageService.updateDormManageById(dormManage);
            return new Message(1,"修改成功！",null);
        }
    }
    //删除方法
    @ResponseBody
    @RequestMapping("/dormmanage/delete")
    public Message deleteTeacherPlanJob(DormManage dormManage){
        dormManageService.deleteDormManageById(dormManage);
        return new Message(1,"删除成功！",null);
    }
    //新增学生校验方法s
    @ResponseBody
    @RequestMapping("/dormmanage/checktsudentdorm")
    public Message checkStudentDorm(StudentDorm studentDorm){
        List<StudentDorm> list = dormManageService.checkStudentDorm(studentDorm);
        if(list.size()>0){
            return new Message(1,"已存在该学生，请重新输入！",null);
        }else{
            return new Message(2,"",null);
        }

    }
    //新增学生校验方法
    @ResponseBody
    @RequestMapping("/dormmanage/checktsudentDelete")
    public Message checkStudentDelete(StudentDorm studentDorm){
        List<StudentDorm> list = dormManageService.checkStudentDelete(studentDorm);
        if(list.size()>0){
            return new Message(1,"该学生已排班，请先删除该学生的排班计划！",null);
        }else{
            return new Message(2,"",null);
        }
    }
    @ResponseBody
    @RequestMapping("/dormmanage/getStudentByClassIdNotDorm")
    public List<Select2> getStudentByClassId(String classId) {
        return dormManageService.getStudentByClassIdNotDorm(classId);
    }
}
