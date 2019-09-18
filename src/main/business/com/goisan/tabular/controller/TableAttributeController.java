package com.goisan.tabular.controller;

import com.goisan.tabular.dao.TableAttributeDao;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class TableAttributeController {
    @Resource
    private TableAttributeDao tableAttributeDao;
}
