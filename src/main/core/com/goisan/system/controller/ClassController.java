package com.goisan.system.controller;

import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.StudentChangeLog;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.StudentChangeLogService;
import com.goisan.system.service.StudentService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
@Controller
public class ClassController {

    @Resource
    private ClassService classService;
    @Resource
    private StudentService studentService;

    @Resource
    private StudentChangeLogService studentChangeLogService;

    @RequestMapping("/classManagement/classList")
    public ModelAndView classList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/classManagement/classList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/classManagement/getclassList")
    public Map<String, List<ClassBean>> getclassList(ClassBean classBean){
        Map<String, List<ClassBean>> classList = new HashMap<String, List<ClassBean>>();
        classBean.setCreateDept(CommonUtil.getDefaultDept());
        classBean.setLevel(CommonUtil.getLoginUser().getLevel());
        classList.put("data",classService.getClassList(classBean));
        return classList;
    }

    @RequestMapping("/classManagement/addClass")
    public ModelAndView addClass() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/classManagement/editClass");
        mv.addObject("head", "班级新增");
        return mv;
    }

    @RequestMapping("/classManagement/updateClass")
    public ModelAndView updateClass(String classId) {
        ClassBean classBean = classService.getClassByClassid(classId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "班级修改");
        mv.addObject("classBean", classBean);
        mv.setViewName("/core/xg/classManagement/editClass");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/classManagement/savaClass")
    @Transactional
    public Message savaClass(ClassBean classBean) {
        List<ClassBean> list = classService.getClassByClass(classBean);
        if(null == classBean.getClassId() || "".equals(classBean.getClassId())){
            if(list.size()>0){
                return new Message(0, "新增失败！班级名称重复", null);
            }else{
                classBean.setCreator(CommonUtil.getPersonId());
                classBean.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
                classService.insertClass(classBean);
                return new Message(1, "新增成功！", null);
            }
        }else{
            if(list.size()>0){
                return new Message(0, "修改失败！班级名称重复", null);
            }else{
                classBean.setChanger(CommonUtil.getPersonId());
                classBean.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
                classService.updateClass(classBean);
                /**
                 * 新增学籍异动,
                 * 2在籍——毕业
                 */
                if ("2".equals(classBean.getGraduationFlag())){
                    /**
                     * classId 获取 在籍学生，新增异动记录，更新
                     */
                    List<Student> zjStuList = classService.getZJStuListByClassId(classBean.getClassId());
                    for (Student student:zjStuList) {
                        String studentId = student.getStudentId();
                        StudentChangeLog studentChangeLog = new StudentChangeLog();
                        studentChangeLog.setChangeType("2");
                        studentChangeLog.setStudentId(studentId);
                        studentChangeLog.setNewCode("6");
                        studentChangeLog.setNewContent("已毕业");
                        studentChangeLog.setOldCode("1");
                        studentChangeLog.setOldContent("在籍");
                        studentChangeLog.setCreateDept(CommonUtil.getDefaultDept());
                        studentChangeLog.setCreator(CommonUtil.getPersonId());
                        studentChangeLogService.saveLog(studentChangeLog);
                    }
                    studentChangeLogService.updateGradStudentStatusByClass(classBean.getClassId(),"6");
                } else if ("3".equals(classBean.getGraduationFlag())){
                    List<Student> zjStuList = classService.getZJStuListByClassId(classBean.getClassId());
                    for (Student student:zjStuList){
                        String studentId = student.getStudentId();
                        StudentChangeLog studentChangeLog = new StudentChangeLog();
                        studentChangeLog.setChangeType("2");
                        studentChangeLog.setStudentId(studentId);
                        studentChangeLog.setNewCode("15");
                        studentChangeLog.setNewContent("应届毕业");
                        studentChangeLog.setOldCode("1");
                        studentChangeLog.setOldContent("在籍");
                        studentChangeLog.setCreateDept(CommonUtil.getDefaultDept());
                        studentChangeLog.setCreator(CommonUtil.getPersonId());
                        studentChangeLogService.saveLog(studentChangeLog);
                    }
                    studentChangeLogService.updateGradStudentStatusByClass(classBean.getClassId(),"15");
                }

                return new Message(1, "修改成功！", null);
            }
        }
    }

    @ResponseBody
    @RequestMapping("/classManagement/delClass")
    public Message delClass(String  classId) {
        //删除班级校验是否有学生数据
       int result=classService.checkDeleteClass(classId);
        if(result==1){
           return new Message(0, "此班级已关联学生信息,不可删除！", "error");
        }
        if(result==2){
            return new Message(0, "此班级已关联考务信息,不可删除！", "error");
        } else{
            classService.delClass(classId);
            return new Message(1, "删除成功！", "success");
        }

    }

    @ResponseBody
    @RequestMapping("/classManagement/getClassByStudentid")
    public Map<String, List> getClassByStudentid() {
        String studentid = CommonUtil.getPersonId();
        String defaultDeptId = CommonUtil.getLoginUser().getDefaultDeptId();
        List<ClassBean>  classBean = classService.getClassListByStudentid(studentid);
        for (Iterator<ClassBean> it = classBean.iterator(); it.hasNext(); ) {
            ClassBean cBean = it.next();
            if(cBean.getClassId().equals(defaultDeptId)){
                cBean.setClassName(cBean.getClassName()+"(默认)");
            }
        }

        return CommonUtil.tableMap(classBean);
    }
    @ResponseBody
    @RequestMapping("/classManagement/checkClassById")
    public Message saveClassResult(String  id) {
        if (classService.getClassByClassid(id)==null){
            return new Message(2, "", "success");
        }
        return new Message(1, "", "success");
    }


}
