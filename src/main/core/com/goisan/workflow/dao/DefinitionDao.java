package com.goisan.workflow.dao;

import com.goisan.workflow.bean.Definition;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Admin on 2017/5/7.
 */
@Repository
public interface DefinitionDao {
    List getDefinitionListByNodeIdAndWorkflowId(@Param("nodeId") String nodeId,
             @Param("workflowId") String workflowId);

    void saveDefinition(Definition definition);

    void deleteDefinition(String id);
}
