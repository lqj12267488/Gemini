package com.goisan.log.controller;

import com.goisan.log.bean.ResourceLog;
import com.goisan.log.service.ResourceLogService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class ResourceLogController {

    @Resource
    private ResourceLogService resourceLogService;

    @RequestMapping("/resourceLibrary/log/toResourceLogList")
    public String toList() {
        return "/resourcelibrary/log/resourceLogList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/log/getResourceLogList")
    public Map getList(ResourceLog resourceLog) {
        if("1".equals(resourceLog.getOperateType())  ){
            resourceLog.setOperateTypeShow("%浏览%");
            return CommonUtil.tableMap(resourceLogService.getResourceLogList(resourceLog));
        }else if("2".equals(resourceLog.getOperateType())){
            resourceLog.setOperateTypeShow("%资源上传%");
            return CommonUtil.tableMap(resourceLogService.getResourceLogList(resourceLog));
        }else if("3".equals(resourceLog.getOperateType())){
            resourceLog.setOperateTypeShow("%下载%");
            return CommonUtil.tableMap(resourceLogService.getResourceLogList(resourceLog));
        }else if("4".equals(resourceLog.getOperateType())){
            resourceLog.setOperateTypeShow("%资源删除%");
            return CommonUtil.tableMap(resourceLogService.getResourceLogList(resourceLog));
        }else{
            return CommonUtil.tableMap(resourceLogService.getResourceLogList(resourceLog));
        }
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/log/getPrivateResourceLogList")
    public Map getPrivateList(ResourceLog resourceLog) {
        return CommonUtil.tableMap(resourceLogService.getPrivateResourceLogList(resourceLog));
    }

    @RequestMapping("/resourceLibrary/log/toResourceLogAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/log/resourceLogEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/log/saveResourceLog")
    public Message save(ResourceLog resourceLog) {
        if ("".equals(resourceLog.getLogId())) {
            resourceLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceLog);
            resourceLogService.saveResourceLog(resourceLog);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceLog);
            resourceLogService.updateResourceLog(resourceLog);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/log/toResourceLogEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", resourceLogService.getResourceLogById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/log/resourceLogEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/log/delResourceLog")
    public Message del(String id) {
        resourceLogService.delResourceLog(id);
        return new Message(0, "删除成功！", "success");
    }

    @RequestMapping("/resourcePrivate/toMyLogList")
    public ModelAndView toMyLogList() {
        ModelAndView mv = new ModelAndView();
        String personId = CommonUtil.getPersonId();
        mv.addObject("personId",personId);
        mv.setViewName("/resourcelibrary/privateResource/myLogList");
        return mv;
    }


}
