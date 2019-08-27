package com.goisan.indexsearch.service;

import com.goisan.indexsearch.bean.ResourceView;

import java.util.List;

/**
 * Created by Administrator on 2017/9/29.
 */

public interface IndexSearchService {
    List<ResourceView> searchResourceList(ResourceView resourceView);

    ResourceView searchResourceById(ResourceView resourceView);

    ResourceView getCountResource(ResourceView resourceView);

    String countSearchResource(ResourceView resourceView);

    List<ResourceView> searchResourceContribution(ResourceView resourceView);

    List<ResourceView> searchMajorContribution(ResourceView resourceView);
}
