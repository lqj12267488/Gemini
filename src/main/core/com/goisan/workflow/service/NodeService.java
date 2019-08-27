package com.goisan.workflow.service;

import com.goisan.system.bean.Select2;
import com.goisan.workflow.bean.Definition;
import com.goisan.workflow.bean.Node;

import java.util.List;

/**
 * Created by Admin on 2017/5/6.
 */
public interface NodeService {
    void saveNode(Node node);

    void deleteNode(String nodeId);

    Node getNodeById(String nodeId);

    void updateNode(Node node);

    List<Select2> getNextNodeList(String workflowId, String nodeId);

    List<Definition> check(String nodeId);
}
