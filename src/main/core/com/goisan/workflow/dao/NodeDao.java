package com.goisan.workflow.dao;

import com.goisan.system.bean.Select2;
import com.goisan.workflow.bean.Definition;
import com.goisan.workflow.bean.Node;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Admin on 2017/5/6.
 */
@ResponseBody
public interface NodeDao {

    void saveNode(Node node);

    void deleteNode(String nodeId);

    Node getNodeById(String nodeId);

    void updateNode(Node node);

    List<Select2> getNextNodeList(@Param("workflowId") String workflowId, @Param("nodeId") String nodeId);

    List<Definition> check(String nodeId);
}
