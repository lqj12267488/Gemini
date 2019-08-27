package com.goisan.workflow.controller;

import com.goisan.system.bean.Select2;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Definition;
import com.goisan.workflow.bean.Node;
import com.goisan.workflow.service.NodeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Admin on 2017/5/6.
 */
@Controller
public class NodeController {
    @Resource
    private NodeService nodeService;

    @RequestMapping("/addNode")
    public ModelAndView addNode(String workflowId) {
        return new ModelAndView("/core/wf/addNode", "workflowId", workflowId);
    }

    @ResponseBody
    @RequestMapping("/saveNode")
    public Message saveNode(Node node) {
        node.setNodeId(CommonUtil.getUUID());
        node.setCreateDept(CommonUtil.getDefaultDept());
        node.setCreator(CommonUtil.getPersonId());
        node.setCreateTime(CommonUtil.getDate());
        nodeService.saveNode(node);
        return new Message(1, "添加成功！", null);
    }

    @RequestMapping("/editNode")
    public ModelAndView editWorkflow(String nodeId) {
        Node node = nodeService.getNodeById(nodeId);
        return new ModelAndView("/core/wf/editNode", "node", node);
    }

    @ResponseBody
    @RequestMapping("/deleteNode")
    public Message deleteNode(String nodeId) {
        Message message = new Message(1, "删除成功！", null);
        List<Definition> definitions = nodeService.check(nodeId);
        if (definitions.size() > 0) {
            message.setStatus(0);
            message.setMsg("当前节点已被使用，不能删除！");
        } else {
            nodeService.deleteNode(nodeId);
        }
        return message;
    }

    @ResponseBody
    @RequestMapping("/updateNode")
    public Message updateNode(Node node) {
        node.setChanger(CommonUtil.getPersonId());
        node.setChangeDept(CommonUtil.getDefaultDept());
        node.setChangeTime(CommonUtil.getDate());
        nodeService.updateNode(node);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/getNextNodeList")
    private List<Select2> getNextNodeList(String workflowId, String nodeId) {
        Select2 select2 = new Select2();
        select2.setId("-1");
        select2.setText("办结");
        List list = nodeService.getNextNodeList(workflowId, nodeId);
        list.add(select2);
        return list;
    }
}
