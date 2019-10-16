package com.goisan.table.controller;

import com.goisan.table.bean.Volunteers;
import com.goisan.table.service.VolunteersService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class VolunteersController {

    @Resource
    private VolunteersService volunteersService;

    @RequestMapping("/volunteers/toVolunteersList")
    public String toVolunteersList() {
        return "/business/table/volunteers/volunteersList";
    }

    @ResponseBody
    @RequestMapping("/volunteers/getVolunteersList")
    public Map<String,Object> getVolunteersList(Volunteers volunteers,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  volunteersService.getVolunteersList(volunteers);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/volunteers/toVolunteersAdd")
    public String toAddVolunteers(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/volunteers/volunteersEdit";
    }

    @ResponseBody
    @RequestMapping("/volunteers/saveVolunteers")
    public Message saveVolunteers(Volunteers volunteers) {
        if (null != volunteers.getId() && !"".equals(volunteers.getId())) {
           CommonUtil.update(volunteers);
            volunteersService.updateVolunteers(volunteers);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(volunteers);
            volunteersService.saveVolunteers(volunteers);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/volunteers/toVolunteersEdit")
    public String toEditVolunteers(String id, Model model) {
        Volunteers volunteers = volunteersService.getVolunteersById(id);
        volunteers.setFounddateStr(new SimpleDateFormat("yyyy-MM-dd").format(volunteers.getFounddate()));
        model.addAttribute("data", volunteers);
        model.addAttribute("head", "修改");
        return "/business/table/volunteers/volunteersEdit";
    }

    @ResponseBody
    @RequestMapping("/volunteers/delVolunteers")
    public Message delVolunteers(String id) {
        volunteersService.delVolunteers(id);
        return new Message(0, "删除成功！", null);
    }

}
