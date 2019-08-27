package com.goisan.task.controller;

import com.goisan.task.bean.SysTask;
import com.goisan.task.service.TaskService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Created by mcq on 2017/8/31.
 */
@Controller
public class TaskController {
    @Resource
    private TaskService taskService;



}
