package com.goisan.educational.timetable.controller;

import com.goisan.educational.timetable.bean.TimeTable;
import com.goisan.educational.timetable.bean.TimeTableSpecialPlace;
import com.goisan.educational.timetable.service.TimeTableService;
import com.goisan.educational.timetable.service.TimeTableSpecialPlaceService;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/timeTableSpecialPlace")
public class TimeTableSpecialPlaceController {

    @Autowired
    private TimeTableSpecialPlaceService timeTableSpecialPlaceService;


    @RequestMapping("/toTimeTableSpecialPlace")
    public ModelAndView toTimeTableSpecialPlace() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/timetable/timeTableSpecialPlaceList");
        return mv;
    }


    @RequestMapping("getTimeTableSpecialPlaceList")
    public Map<String, List> getTimeTableSpecialPlaceList(TimeTableSpecialPlace timeTableSpecialPlace) {
        timeTableSpecialPlace.setCreateDept(CommonUtil.getDefaultDept());
        return CommonUtil.tableMap(timeTableSpecialPlaceService.getTimeTableSpecialPlaceList(timeTableSpecialPlace));

    }

    @RequestMapping("/toTimeTableSpecialPlaceAdd")
    public ModelAndView toTimeTableSpecialPlaceAdd(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/timetable/timeTableSpecialPlaceEdit");
        if (id != null && !"".equals(id)) {
            TimeTableSpecialPlace timeTableSpecialPlace = timeTableSpecialPlaceService.getTimeTableSpecialPlaceById(id);
            mv.addObject("data", timeTableSpecialPlace);
            mv.addObject("head", "修改");
        } else {
            mv.addObject("head", "新增");
        }
        return mv;
    }


    @RequestMapping("deleteTimeTableSpecialPlace")
    public Message deleteTimeTableSpecialPlace(String id) {
        timeTableSpecialPlaceService.deleteTimeTableSpecialPlace(id);
        return new Message(1, "删除成功！", null);
    }


    @RequestMapping("saveTimeTableSpecialPlace")
    public Message saveTimeTableSpecialPlace(TimeTableSpecialPlace timeTableSpecialPlace) {
        if (timeTableSpecialPlace.getId() != null && !"".equals(timeTableSpecialPlace.getId())) {
            timeTableSpecialPlaceService.updateTimeTableSpecialPlace(timeTableSpecialPlace);
            return new Message(0, "修改成功！", null);
        } else {
            timeTableSpecialPlace.setId(CommonUtil.getUUID());
            timeTableSpecialPlace.setCreateDept(CommonUtil.getDefaultDept());
            timeTableSpecialPlaceService.saveTimeTableSpecialPlace(timeTableSpecialPlace);
            return new Message(0, "新增成功！", null);
        }
    }

    @RequestMapping("/getTimeTableSpecialPlaceList4Select")
    public List<Select2> getTimeTableSpecialPlaceList4Select() {
        return timeTableSpecialPlaceService.getTimeTableSpecialPlaceList4Select();

    }


}





