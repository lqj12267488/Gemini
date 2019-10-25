package com.goisan.table.controller;

import com.goisan.table.bean.MachineClassroom;
import com.goisan.table.bean.ManagementInformation;
import com.goisan.table.service.MachineClassroomService;
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
import java.util.*;

@Controller
public class MachineClassroomController {

    @Resource
    private MachineClassroomService machineClassroomService;

    @RequestMapping("/machineclassroom/toMachineClassroomList")
    public String toMachineClassroomList() {
        return "/business/table/machineclassroom/machineClassroomList";
    }

    @ResponseBody
    @RequestMapping("/machineclassroom/getMachineClassroomList")
    public Map<String,Object> getMachineClassroomList(MachineClassroom machineClassroom,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  machineClassroomService.getMachineClassroomList(machineClassroom);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/machineclassroom/toMachineClassroomAdd")
    public String toAddMachineClassroom(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/machineclassroom/machineClassroomEdit";
    }

    @ResponseBody
    @RequestMapping("/machineclassroom/saveMachineClassroom")
    public Message saveMachineClassroom(MachineClassroom machineClassroom) {
        if (null != machineClassroom.getId() && !"".equals(machineClassroom.getId())) {
           CommonUtil.update(machineClassroom);
            machineClassroomService.updateMachineClassroom(machineClassroom);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(machineClassroom);
            machineClassroomService.saveMachineClassroom(machineClassroom);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/machineclassroom/toMachineClassroomEdit")
    public String toEditMachineClassroom(String id, Model model) {
        model.addAttribute("data", machineClassroomService.getMachineClassroomById(id));
        model.addAttribute("head", "修改");
        return "/business/table/machineclassroom/machineClassroomEdit";
    }

    @ResponseBody
    @RequestMapping("/machineclassroom/delMachineClassroom")
    public Message delMachineClassroom(String id) {
        machineClassroomService.delMachineClassroom(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/machineclassroom/checkYear")
    public Message machineClassroomCheckYear(MachineClassroom machineClassroom){
        List size = machineClassroomService.checkYear(machineClassroom);
        if(size.size()>0){
            return new Message(1, "年份重复，请重新选择！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}
