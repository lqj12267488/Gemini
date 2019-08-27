package com.goisan.system.controller;

import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.StudentParentRelation;
import com.goisan.system.service.LoginUserService;
import com.goisan.system.service.StudentParentRelationService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
public class StudentParentRelationController {

    @Resource
    private StudentParentRelationService studentParentRelationService;

    @RequestMapping("/core/parent/toStudentParentRelationList")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/relation/studentParentRelationList");
        return mv;
    }

    // 家长关联学生
    @RequestMapping("/core/parent/toParentRelationList")
    public ModelAndView toParentRelationList(String parentId,String parentName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/relation/parentRelationList");
        mv.addObject("parentId",parentId);
        mv.addObject("parentName",parentName);
        return mv;
    }

    // 学生关联家长
    @RequestMapping("/core/parent/toStudentRelationList")
    public ModelAndView toStudentRelationList(String studentId,String studentName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("core/xg/parent/relation/studentParentRelationEdit");
        mv.addObject("studentId",studentId);
        mv.addObject("studentName",studentName);
        StudentParentRelation studentParentRelation = new StudentParentRelation();
        studentParentRelation.setStudentId(studentId);
        List studentRelation = studentParentRelationService.getStudentParentRelationList(studentParentRelation);
        if(null == studentRelation || studentRelation.size() == 0){
            mv.addObject("studentRelation",studentParentRelation);
        }else{
            mv.addObject("studentRelation",studentRelation.get(0));
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/core/parent/getStudentParentRelationList")
    public Map getList(StudentParentRelation studentParentRelation) {
        return CommonUtil.tableMap(studentParentRelationService.getStudentParentRelationList(studentParentRelation));
    }

    @RequestMapping("/core/parent/toStudentParentRelationAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/core/xg/parent/relation/studentParentRelationEdit";
    }

    @RequestMapping("/core/parent/toStudentRelationAdd")
    public ModelAndView toStudentParentRelation(String parentId,String parentName) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/relation/parentStudentRelationEdit");
        mv.addObject("parentId",parentId);
        mv.addObject("parentName",parentName);
        mv.addObject("head", "新增关联学生");
        return mv;
    }

    @Resource
    private LoginUserService loginUserService;

    @ResponseBody
    @RequestMapping("/core/parent/saveStudentParentRelation")
    public Message save(StudentParentRelation studentParentRelation) {
        if ("".equals(studentParentRelation.getId())) {
            List list =  studentParentRelationService.checkStudentRelation(studentParentRelation.getStudentId());
            if(null == list || list.size() == 0){
                studentParentRelation.setId(CommonUtil.getUUID());
                CommonUtil.save(studentParentRelation);

                loginUserService.upadtedefaultDeptId(CommonUtil
                        .getLoginUser().getUserAccount(), studentParentRelation.getStudentId());

                studentParentRelationService.saveStudentParentRelation(studentParentRelation);
                return new Message(1, "添加成功！", "success");
            }else{
                StudentParentRelation stu = (StudentParentRelation) list.get(0);
                return new Message(0,
                        studentParentRelation.getStudentName()+" 学生已绑定"
                                +stu.getParentName()+",    不可同时设置多位家长", "error");
            }
        } else {
            CommonUtil.update(studentParentRelation);
            studentParentRelationService.updateStudentParentRelation(studentParentRelation);
            return new Message(1, "修改成功！", "success");
        }
    }

    @RequestMapping("/core/parent/toStudentParentRelationEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", studentParentRelationService.getStudentParentRelationById(id));
        model.addAttribute("head", "修改");
        return "/core/xg/parent/relation/studentParentRelationEdit";
    }

    @ResponseBody
    @RequestMapping("/core/parent/delStudentParentRelation")
    public Message del(String id) {
        studentParentRelationService.delStudentParentRelation(id);
        return new Message(1, "删除成功！", "success");
    }

    @ResponseBody
    @RequestMapping("/core/parent/getClassByPersonId")
    public Map<String, List> getClassByStudentid() {
        String parentId = CommonUtil.getPersonId();
        String defaultStudentId = CommonUtil.getLoginUser().getDefaultDeptId();
        StudentParentRelation stuParRelation = new StudentParentRelation();
        stuParRelation.setParentId(parentId);
        List list = studentParentRelationService.getStudentParentRelationList(stuParRelation);
        List<StudentParentRelation> spList = (List<StudentParentRelation>)list;
        for (Iterator<StudentParentRelation> it = spList.iterator(); it.hasNext(); ) {
            StudentParentRelation s = it.next();
            if(s.getStudentId().equals(defaultStudentId)){
                s.setStudentName(s.getStudentName()+"(默认)");
            }
        }
        return CommonUtil.tableMap(spList);
    }

}
