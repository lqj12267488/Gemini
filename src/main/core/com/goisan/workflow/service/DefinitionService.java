package com.goisan.workflow.service;

import com.goisan.workflow.bean.Definition;

import java.util.List;

/**
 * Created by Admin on 2017/5/7.
 */
public interface DefinitionService {
    List getDefinitionListByNodeIdAndWorkflowId(String nodeId, String workflowId);

    void saveDefinition(Definition definition);

    void deleteDefinition(String definitionId);
}
