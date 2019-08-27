package com.goisan.workflow.service.impl;

import com.goisan.workflow.bean.Definition;
import com.goisan.workflow.dao.DefinitionDao;
import com.goisan.workflow.service.DefinitionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Admin on 2017/5/7.
 */
@Service
public class DefinitionServiceImpl implements DefinitionService {
    @Resource
    private DefinitionDao definitionDao;

    public List getDefinitionListByNodeIdAndWorkflowId(String nodeId, String workflowId) {
        return definitionDao.getDefinitionListByNodeIdAndWorkflowId(nodeId, workflowId);
    }

    public void saveDefinition(Definition definition) {
        definitionDao.saveDefinition(definition);
    }

    public void deleteDefinition(String definitionId) {
        definitionDao.deleteDefinition(definitionId);
    }
}
