package com.goisan.studentwork.internships.controller;


import com.goisan.studentwork.internships.bean.InternshipChangeLog;
import com.goisan.studentwork.internships.service.InternshipChangeLogService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanyu on 2017/8/3.
 */
@Controller
public class InternshipChangeLogController {
    @Resource
    private InternshipChangeLogService internshipChangeLogService;

    @RequestMapping("/internshipChangeLog/internshipsList1")
    public String internshipExt1(Model model) {
        return "/business/studentwork/internships/internshipManageList";
    }

    @ResponseBody
    @RequestMapping("/internshipChangeLog/InternshipChangeLogActionById")
    public Map<String, List<InternshipChangeLog>> InternshipChangeLogActionById(InternshipChangeLog internshipChangeLog) {
        Map<String, List<InternshipChangeLog>> internshipChangeLogMap = new HashMap<String, List<InternshipChangeLog>>();
        internshipChangeLogMap.put("data", internshipChangeLogService.InternshipChangeLogActionById(internshipChangeLog));
        return internshipChangeLogMap;
    }
    /**
     * 实习单位维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param internshipChangeLog
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipChangeLog/InternshipChangeLogAction")
    public Map<String, List<InternshipChangeLog>> InternshipChangeLogAction(InternshipChangeLog internshipChangeLog) {
        Map<String, List<InternshipChangeLog>> internshipChangeLogMap = new HashMap<String, List<InternshipChangeLog>>();
        internshipChangeLogMap.put("data", internshipChangeLogService.InternshipChangeLogAction(internshipChangeLog));
        return internshipChangeLogMap;
    }

    /**
     * 实习单位维护修改
     * update by hanyue
     * modify by hanyue
     * @param logId
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipChangeLog/getInternshipChangeLogById")
    public ModelAndView getInternshipChangeLogById(String logId) {
        InternshipChangeLog internshipChangeLog = internshipChangeLogService.getInternshipChangeLogById(logId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改");
        mv.addObject("internshipChangeLog", internshipChangeLog);
        mv.setViewName("/business/studentwork/internships/updateInternshipChangeLog");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/internshipChangeLog/getInternshipChangeLogId")
    public ModelAndView getInternshipChangeLogId(String logId) {
        ModelAndView mv = new ModelAndView("/business/studentwork/internships/addInternshipChangeLog");
        InternshipChangeLog internshipChangeLog = internshipChangeLogService.getInternshipChangeLogId(logId);
        mv.addObject("head", "查看详情");
        mv.addObject("internshipChangeLog", internshipChangeLog);
        return mv;
    }

    /**
     * 删除实习单位
     * delete by hanyue
     * modify by hanyue
     * @param logId
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipChangeLog/deleteInternshipChangeLogById")
    public Message deleteInternshipChangeLogById(String logId) {
        internshipChangeLogService.deleteInternshipChangeLogById(logId);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 保存实习单位
     * save by hanyue
     * modify by hanyue
     * @param internshipChangeLog
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipChangeLog/saveInternshipChangeLog")
    public Message saveInternshipChangeLog(InternshipChangeLog internshipChangeLog){
        if(internshipChangeLog.getLogId()==null || internshipChangeLog.getLogId().equals("")){
            internshipChangeLog.setCreator(CommonUtil.getPersonId());
            internshipChangeLog.setCreateDept(CommonUtil.getDefaultDept());
            internshipChangeLogService.insertInternshipChangeLog(internshipChangeLog);
            List<InternshipChangeLog> list=internshipChangeLogService.selectInternshipChangeLogList(internshipChangeLog.getInternshipId());
            internshipChangeLog.setInternshipChangeFlagFlag(list.size());
            if(list.size()>3){
                internshipChangeLogService.updateInternshipManageChangeLog(internshipChangeLog);
            }else{
                internshipChangeLogService.updateInternshipManage(internshipChangeLog);
            }
            return new Message(1, "新增成功！", null);
        }else{
            internshipChangeLog.setChanger(CommonUtil.getPersonId());
            internshipChangeLog.setChangeDept(CommonUtil.getDefaultDept());
            internshipChangeLogService.updateInternshipChangeLogById(internshipChangeLog);
            return new Message(1, "修改成功！", null);
        }
    }
}
