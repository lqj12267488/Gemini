package com.goisan.system.tools;

import com.goisan.evaluation.bean.EvaluationTask;
import com.goisan.evaluation.service.EvaluationService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Component
public class TimerTask {
    @Resource
    public EvaluationService evaluationService;

    @Scheduled(cron = "0 0 16 * * ?")
    public void test(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        List<EvaluationTask> leaderList =evaluationService.getTaskResultList();
        for (EvaluationTask leader: leaderList){
            int res= leader.getEndTime().toString().split(" ")[0].compareTo(df.format(new Date()));
            if(res<0){
                evaluationService.setStartFlagByTaskId(leader.getTaskId(), "2");
            }
        }
    }
}
