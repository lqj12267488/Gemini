package com.goisan.workflow.service.impl;

import com.goisan.system.bean.Select2;
import com.goisan.workflow.bean.Definition;
import com.goisan.workflow.bean.Node;
import com.goisan.workflow.dao.NodeDao;
import com.goisan.workflow.service.NodeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Admin on 2017/5/6.
 */
@Service
public class NodeServiceImpl implements NodeService {
    @Resource
    private NodeDao nodeDao;

    public void saveNode(Node node) {
        nodeDao.saveNode(node);
    }

    public void deleteNode(String nodeId) {
        nodeDao.deleteNode(nodeId);
    }

    public Node getNodeById(String nodeId) {
        return nodeDao.getNodeById(nodeId);
    }

    public void updateNode(Node node) {
        nodeDao.updateNode(node);
    }

    public List<Select2> getNextNodeList(String workflowId, String nodeId) {
        return nodeDao.getNextNodeList(workflowId, nodeId);
    }

    @Override
    public List<Definition> check(String nodeId) {
        return nodeDao.check(nodeId);
    }
}
