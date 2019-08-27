package com.goisan.collection.controller;

/**
 * Created by admin on 2017/10/19.
 */
import com.goisan.log.service.ResourceLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

@Service
public class ResourceStatisticsTask {
    @Resource
    private ResourceLogService resourceLogService;

    /** 收藏，浏览，下载 统计
     * 路径
     * \src\main\resources\Spring-mvc.xml.
     * <task:scheduled ref="resourceStatisticsTask" method="job1" cron="0/20 * * * * ?"/>
     */
    public void job1() {
        resourceLogService.delStatistics();
        System.out.println("   ResourceStatisticsTask  delStatistics       over-->date :"+new Date());
        resourceLogService.insertStatistics();
        System.out.println("   ResourceStatisticsTask  insertStatistics    over-->date :"+new Date());
    }
}
