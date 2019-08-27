package com.goisan.system.service.impl;

import com.goisan.system.bean.Parameter;
import com.goisan.system.dao.ParameterDao;
import com.goisan.system.service.ParameterService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ParameterServiceImpl implements ParameterService{
    @Resource
    private ParameterDao parameterDao;
    public List<Parameter> parameterInfo(Parameter parameter) {
        return parameterDao.parameterInfo(parameter);
    }

    public void insertParameter(Parameter parameter) {
        parameterDao.insertParameter(parameter);
    }

    public Parameter getParameterID(String id) {
        return parameterDao.getParameterID(id);
    }

    public void updateParameter(Parameter parameter) {
        parameterDao.updateParameter(parameter);
    }

    public void deleteParameter(String id) {
        parameterDao.deleteParameter(id);
    }

    public List<Parameter> checkName(Parameter parameter) {
        return parameterDao.checkName(parameter);
    }

    public List<Parameter> checkCode(Parameter parameter) {
        return parameterDao.checkCode(parameter);
    }

    public List<Parameter> checkType(Parameter parameter) {
        return parameterDao.checkType(parameter);
    }

    public List<Parameter> checkValue(Parameter parameter) {
        return parameterDao.checkValue(parameter);
    }

    @Override
    public void updateSemester(Parameter parameter) {
        parameterDao.updateSemester(parameter);
    }

    @Override
    public void updateSyear(Parameter parameter) {
        parameterDao.updateSyear(parameter);
    }

    @Override
    public String getParameterValue() {
        return parameterDao.getParameterValue();
    }
    @Override
    public String getParameterYearValue() {
        return parameterDao.getParameterYearValue();
    }
}
