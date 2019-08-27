package com.goisan.workflow.controller;

import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Definition;
import com.goisan.workflow.bean.Node;
import com.goisan.workflow.service.DefinitionService;
import com.goisan.workflow.service.NodeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by Admin on 2017/5/7.
 */
@Controller
public class DefinitionController {
    @Resource
    private DefinitionService definitionService;
    @Resource
    private NodeService nodeService;
    @ResponseBody
    @RequestMapping("getDefinitionListByNodeIdAndWorkflowId")
    public Map getDefinitionListByNodeIdAndWorkflowId(String nodeId, String workflowId) {
        return CommonUtil.tableMap(definitionService.getDefinitionListByNodeIdAndWorkflowId
                (nodeId, workflowId));
    }

    @ResponseBody
    @RequestMapping("/saveDefinition")
    public Message saveDefinition(Definition definition) {
        definition.setId(CommonUtil.getUUID());
        definition.setCreator(CommonUtil.getPersonId());
        definition.setCreateDept(CommonUtil.getDefaultDept());
        definition.setCreateTime(CommonUtil.getDate());
        definitionService.saveDefinition(definition);
        return new Message(1, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/deleteDefinition")
    public Message deleteDefinition(String definitionId) {
        definitionService.deleteDefinition(definitionId);
        return new Message(1, "删除成功！", null);
    }

    @RequestMapping("/definition")
    public ModelAndView definition(String nodeId, String workflowId, String workflowName) {
        Node node = nodeService.getNodeById(nodeId);
        String nodeName = node.getNodeName();
        ModelAndView mv = new ModelAndView("/core/wf/definition");
        mv.addObject("workflowName",workflowName);
        mv.addObject("nodeName",nodeName);
        mv.addObject("nodeId", nodeId);
        mv.addObject("workflowId", workflowId);
        return mv;
    }

    @RequestMapping("/addDefinition")
    public ModelAndView addDefinition(String nodeId) {
        return new ModelAndView("/core/wf/addDefinition", "nodeId", nodeId);
    }
}
