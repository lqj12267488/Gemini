package com.goisan.workflow.util;

import com.goisan.workflow.service.UpdateBusinessService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
public class UpdateBusiness {

    @Resource
    private UpdateBusinessService updateBusinessService;

    public void updateBusiness(String tableName, String businessId) {
        if ("".equals(tableName)) {
        }
    }

    public void stopBusiness(String tableName, String businessId) {
        if ("".equals(tableName)) {
            updateBusinessService.update(businessId);
        }
    }
}
