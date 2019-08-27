package com.goisan.operateLog.controller;

import com.goisan.operateLog.bean.ResourceOperateLog;
import com.goisan.operateLog.service.ResourceOperateLogService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class ResourceOperateLogController {

    @Resource
    private ResourceOperateLogService resourceOperateLogService;

    @RequestMapping("/resourceLibrary/operateLog/toResourceOperateLogList")
    public String toList() {
        return "/resourcelibrary/operateLog/resourceOperateLogList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/operateLog/getResourceOperateLogList")
    public Map getList(ResourceOperateLog resourceOperateLog) {
        return CommonUtil.tableMap(resourceOperateLogService.getResourceOperateLogList(resourceOperateLog));
    }

    @RequestMapping("/resourceLibrary/operateLog/toResourceOperateLogAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/operateLog/resourceOperateLogEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/operateLog/saveResourceOperateLog")
    public Message save(ResourceOperateLog resourceOperateLog) {
        if ("".equals(resourceOperateLog.getLogId())) {
            resourceOperateLog.setLogId(CommonUtil.getUUID());
            CommonUtil.save(resourceOperateLog);
            resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceOperateLog);
            resourceOperateLogService.updateResourceOperateLog(resourceOperateLog);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/operateLog/toResourceOperateLogEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", resourceOperateLogService.getResourceOperateLogById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/operateLog/resourceOperateLogEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/operateLog/delResourceOperateLog")
    public Message del(String id) {
        resourceOperateLogService.delResourceOperateLog(id);
        return new Message(0, "删除成功！", "success");
    }

}
