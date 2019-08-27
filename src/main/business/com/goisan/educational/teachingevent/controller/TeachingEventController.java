package com.goisan.educational.teachingevent.controller;

import com.goisan.educational.teachingevent.bean.TeachingEvent;
import com.goisan.educational.teachingevent.service.TeachingEventService;
import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
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
 * Created by znw on 2017/7/13.
 */
@Controller
public class TeachingEventController {
    @Resource
    private TeachingEventService teachingEventService;
    /**
     * 教研活动上报跳转
     * @return
     */
    @RequestMapping("/educational/teachingEvent")
    public ModelAndView teachingEventList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingevent/teachingEventList");
        return mv;
    }
    /**
     * 教研活动统计跳转
     * @return
     */
    @RequestMapping("/educational/teachingEventCount")
    public ModelAndView teachingEventCountList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/teachingevent/teachingEventCountList");
        return mv;
    }

    /**
     * 教研活动上报列表页
     * @param teachingEvent
     * @return dataTable数据
     */
    @ResponseBody
    @RequestMapping("/educational/teachingEvent/getTeachingEventList")
    public Map<String,List<TeachingEvent>> getTeachingEventList(TeachingEvent teachingEvent) {
       Map<String, List<TeachingEvent>> teachingEventMap = new HashMap<String, List<TeachingEvent>>();
        teachingEvent.setCreator(CommonUtil.getPersonId());
        teachingEvent.setCreateDept(CommonUtil.getDefaultDept());
        teachingEvent.setLevel(CommonUtil.getLoginUser().getLevel());
        teachingEventMap.put("data", teachingEventService.getTeachingEventList(teachingEvent));
        return teachingEventMap;
    }
    /**
     * 教研活动统计列表页
     * @param teachingEvent
     * @return dataTable数据
     */
    @ResponseBody
    @RequestMapping("/educational/teachingEvent/getTeachingEventCountList")
    public Map<String,List<TeachingEvent>> getTeachingEventCountList(TeachingEvent teachingEvent) {
        Map<String, List<TeachingEvent>> teachingEventMap = new HashMap<String, List<TeachingEvent>>();
        teachingEvent.setCreator(CommonUtil.getPersonId());
        teachingEvent.setCreateDept(CommonUtil.getDefaultDept());
        teachingEvent.setLevel(CommonUtil.getLoginUser().getLevel());
        teachingEventMap.put("data", teachingEventService.getTeachingEventCountList(teachingEvent));
        return teachingEventMap;
    }

    /**
     * 教研活动上报
     * @return
     */
    @RequestMapping("/educational/teachingEvent/editTeachingEvent")
    public ModelAndView addTeachingEvent() {
        ModelAndView mv = new ModelAndView("/business/educational/teachingevent/editTeachingEvent");
        mv.addObject("head", "教研活动上报");
        return mv;
    }

    /**
     * 教研活动修改
     * @param id
     * @return teachingEvent
     */
    @ResponseBody
    @RequestMapping("/educational/teachingEvent/getTeachingEventById")
    public ModelAndView getTeachingEventById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/teachingevent/editTeachingEvent");
        TeachingEvent teachingEvent = teachingEventService.getTeachingEventById(id);
        mv.addObject("head", "教研活动修改");
        mv.addObject("teachingEvent", teachingEvent);
        return mv;
    }
    /**
     * 保存上报数据
     * @param teachingEvent
     * @return
     */
    @ResponseBody
    @RequestMapping("/educational/teachingEvent/saveTeachingEvent")
    public Message saveTeachingEvent(TeachingEvent teachingEvent){
        if(teachingEvent.getId()==null || teachingEvent.getId().equals("")){
            teachingEvent.setCreator(CommonUtil.getPersonId());
            teachingEvent.setCreateDept(CommonUtil.getDefaultDept());
            teachingEvent.setId(CommonUtil.getUUID());
            teachingEventService.insertTeachingEvent(teachingEvent);
            return new Message(1, "新增成功！", null);
        }else{
            teachingEvent.setChanger(CommonUtil.getPersonId());
            teachingEvent.setChangeDept(CommonUtil.getDefaultDept());
            teachingEventService.updateTeachingEventById(teachingEvent);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除上报活动
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/educational/teachingEvent/deleteTeachingEventById")
    public Message deleteTeachingEventById(String id) {
        teachingEventService.deleteTeachingEventById(id);
        return new Message(1, "删除成功！", null);
    }
}
