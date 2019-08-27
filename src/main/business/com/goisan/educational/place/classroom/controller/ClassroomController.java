package com.goisan.educational.place.classroom.controller;

import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.educational.place.classroom.service.ClassroomService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

/**教室场地维护
 * Created by wq on 2017/7/15.
 */
@Controller
public class ClassroomController {
    @Resource
    private ClassroomService classroomService;

    /*跳转到教室场地维护JSP*/
    @RequestMapping("/classroom/request")
    public ModelAndView classroomAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/place/classroom/classroomList");
        return mv;
    }

    /*管理页列表显示和查询*/
    @ResponseBody
    @RequestMapping("/classroom/getClassroomList")
    public Map<String, List<Classroom>> getClassroomList(Classroom classroom) {
        Map<String, List<Classroom>> classroomMap = new HashMap<String, List<Classroom>>();
        classroom.setCreator(CommonUtil.getPersonId());
        classroom.setChangeDept(CommonUtil.getDefaultDept());
        classroomMap.put("data", classroomService.getClassroomList(classroom));
        return classroomMap;
    }

    /***
     * 功能：跳转到教室场地编辑界面进行新增(包括教室名称，楼宇ID，容纳人数，所在楼层，使用状态，备注)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/classroom/insertClassroom")
    public ModelAndView insertClassroom() {
        ModelAndView mv = new ModelAndView("business/educational/place/classroom/editClassroom");
        mv.addObject("head", "教室场地新增");
        return mv;
    }

    /**
     * 功能：跳转到教室场地编辑界面进行修改（回显原教室场地信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/classroom/updateClassroom")
    public ModelAndView updateClassroom(String id) {
        ModelAndView mv = new ModelAndView("business/educational/place/classroom/addClassRoom");
        Classroom classroom = classroomService.getClassroomById(id);
        mv.addObject("head", "教室场地修改");
        mv.addObject("classroom", classroom);
        return mv;
    }

    /**
     * 功能：申请信息保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     *
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/classroom/saveClassroom")
    public Message saveClassroom(Classroom classroom) {
        if (classroom.getId() == null || classroom.getId().equals("")) {
            classroom.setId(CommonUtil.getUUID());
            classroom.setCreator(CommonUtil.getPersonId());
            classroom.setCreateDept(CommonUtil.getDefaultDept());
            classroomService.insertClassroom(classroom);
            return new Message(1, "新增成功！", null);
        } else {
            classroom.setChanger(CommonUtil.getPersonId());
            classroom.setChangeDept(CommonUtil.getDefaultDept());
            classroomService.updateClassroom(classroom);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/classroom/deleteClassroom")
    public Message deleteClassroom(String id) {
        Message message=new Message();
        List<String> list = classroomService.checkApplyClass(id);
        if(list.size() > 0){
            message.setStatus(0);
            message.setMsg("当前教室下有班级信息，不能删除！");
            message.setResult("info");
        }else {
            classroomService.deleteClassroom(id);
            message.setStatus(1);
            message.setMsg("删除成功！");
            message.setResult("success");
        }
        return message;
    }

    /*名称查重*/
    @ResponseBody
    @RequestMapping("/classroom/checkName")
    public Message checkName(Classroom classroom) {
        List size = classroomService.checkName(classroom);
        if (size.size() > 0) {
            return new Message(1, "教室名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }
    /*查询条件--寝室名称模糊查询*/
    @ResponseBody
    @RequestMapping("/classroom/selectClassroomName")
    public List<AutoComplete> selectClassroomName() {
        List<AutoComplete> list = classroomService.selectClassroomName();
        return classroomService.selectClassroomName();
    }
}