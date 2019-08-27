package com.goisan.approval.controller;

import com.goisan.approval.bean.ResourceApproval;
import com.goisan.approval.bean.ResourcePrivate;
import com.goisan.approval.service.ResourceApprovalService;
import com.goisan.approval.service.ResourcePrivateService;
import com.goisan.operateLog.bean.ResourceOperateLog;
import com.goisan.operateLog.service.ResourceOperateLogService;
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
public class ResourceApprovalController {

    @Resource
    private ResourceApprovalService resourceApprovalService;

    @RequestMapping("/resourceLibrary/approval/toResourceApprovalList")
    public String toList() {
        return "/resourcelibrary/approval/resourceApprovalList";
    }


    @ResponseBody
    @RequestMapping("/resourceLibrary/approval/getResourceApprovalList")
    public Map getList(ResourceApproval resourceApproval) {
        return CommonUtil.tableMap(resourceApprovalService.getResourceApprovalList(resourceApproval));
    }

    @RequestMapping("/resourceLibrary/approval/toResourceApprovalAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/approval/resourceApprovalEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/approval/saveResourceApproval")
    public Message save(ResourceApproval resourceApproval) {
        if ("".equals(resourceApproval.getApprovalId())) {
            resourceApproval.setApprovalId(CommonUtil.getUUID());
            CommonUtil.save(resourceApproval);
            resourceApprovalService.saveResourceApproval(resourceApproval);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceApproval);
            resourceApprovalService.updateResourceApproval(resourceApproval);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/approval/toResourceApprovalEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", resourceApprovalService.getResourceApprovalById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/approval/resourceApprovalEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/approval/delResourceApproval")
    public Message del(ResourceApproval resourceApproval) {
        String id = resourceApproval.getApprovalId();
        String resourceId = resourceApproval.getResourceId();
        resourceApprovalService.delResourceApproval(id);
        resourceApprovalService.updateResourcePublice(resourceId);
        return new Message(0, "删除成功！", "success");
    }
    @Resource
    private ResourcePrivateService resourcePrivateService;

    @ResponseBody
    @RequestMapping("/resourceLibrary/approval/setResourceApproval")
    public Message setResourceApproval(ResourceApproval resourceApproval) {
        ResourcePrivate resourcePrivate = new ResourcePrivate();
        resourcePrivate.setResourceId(resourceApproval.getResourceId());
        CommonUtil.update(resourcePrivate);
        if(resourceApproval.getRequestFlag().equals("2") && resourceApproval.getApprovalFlag().equals("1") ){
            if(resourceApproval.getRequestType().equals("1"))
                resourcePrivate.setPublicFlag("1");
            else if(resourceApproval.getRequestType().equals("2"))
                resourcePrivate.setClassicFlag("1");
        }else if(resourceApproval.getRequestFlag().equals("3") && resourceApproval.getApprovalFlag().equals("0") ){
            if(resourceApproval.getRequestType().equals("1"))
                resourcePrivate.setPublicFlag("0");
            else if(resourceApproval.getRequestType().equals("2"))
                resourcePrivate.setClassicFlag("0");
        }
        resourcePrivateService.updatePrivateFlag(resourcePrivate);
        resourceApproval.setApprover(CommonUtil.getPersonId());
        resourceApproval.setApprovalDept(CommonUtil.getDefaultDept());
        CommonUtil.update(resourceApproval);
        resourceApprovalService.setResourceApproval(resourceApproval);

        ResourceOperateLog resourceOperateLog = new ResourceOperateLog();
        resourceOperateLog.setResourceId(resourceApproval.getResourceId());
        resourceOperateLog.setBusinessId(resourceApproval.getApprovalId());
        resourceOperateLog.setLogId(CommonUtil.getUUID());
        CommonUtil.save(resourceOperateLog);
        resourceOperateLog.setResourceTablename("ZYK_APPROVAL");
        resourceOperateLog.setOperateType("5");
        resourceOperateLogService.saveResourceOperateLog(resourceOperateLog);

        return new Message(1, "审核完成！", "success");
    }
    @Resource
    private ResourceOperateLogService resourceOperateLogService;

    @RequestMapping("/resourceLibrary/approval/approvalResource")
    public ModelAndView approvalResource(String approvalId) {
        ModelAndView mv = new ModelAndView("/resourcelibrary/approval/approvalResource");
        mv.addObject("approvalId",approvalId);
        mv.addObject("data", resourceApprovalService.getResourceApprovalById(approvalId));
        return mv;
    }

    @RequestMapping("/resourceLibrary/approval/approvalPublic")
    public ModelAndView approvalPublic(String approvalId) {
        ModelAndView mv = new ModelAndView("/resourcelibrary/approval/approvalPublic");
        mv.addObject("approvalId",approvalId);
        mv.addObject("data", resourceApprovalService.getResourceApprovalById(approvalId));
        return mv;
    }

    @RequestMapping("/resourceLibrary/approval/setPublicResource2")
    public ModelAndView setPublicResource2(String approvalId,String resourceName,String resourceId,String requester,String resourceType,String uploadPersonCode,String uploadDeptCode) {
        ModelAndView mv = new ModelAndView("/resourcelibrary/approval/setPublicResource2");
        mv.addObject("approvalId",approvalId);
        mv.addObject("resourceName",resourceName);
        mv.addObject("resourceId",resourceId);
        mv.addObject("requester",requester);
        mv.addObject("resourceType",resourceType);
        mv.addObject("uploadPersonCode",uploadPersonCode);
        mv.addObject("uploadDeptCode",uploadDeptCode);
        return mv;
    }


    @RequestMapping("/resourceLibrary/approval/setPublicResource")
    public ModelAndView setPublicResource(String approvalId,String resourceName,String resourceId,String requester) {
        ModelAndView mv = new ModelAndView("/resourcelibrary/approval/setPublicResource");
        mv.addObject("approvalId",approvalId);
        mv.addObject("resourceName",resourceName);
        mv.addObject("resourceId",resourceId);
        mv.addObject("requester",requester);
        return mv;
    }

    @RequestMapping("/resourceLibrary/approval/myApprovalList")
    public ModelAndView myApprovalList() {
        ModelAndView mv = new ModelAndView("/resourcelibrary/privateResource/myApprovalList");
        mv.addObject("personId",CommonUtil.getPersonId());
        return mv;
    }

    @RequestMapping("/resourceLibrary/approval/myApproval")
    public ModelAndView myApproval() {
        ModelAndView mv = new ModelAndView("/resourcelibrary/privateResource/myApprovalList");
        mv.addObject("personId",CommonUtil.getPersonId());
        return mv;
    }

}
