package com.goisan.system.service;

import com.goisan.system.bean.Parameter;

import java.util.List;

public interface ParameterService {
    List<Parameter> parameterInfo(Parameter parameter);
    void insertParameter(Parameter parameter);
    Parameter getParameterID(String id);
    void updateParameter(Parameter parameter);
    void deleteParameter(String id);
    List<Parameter> checkName(Parameter parameter);
    List<Parameter> checkCode(Parameter parameter);
    List<Parameter> checkType(Parameter parameter);
    List<Parameter> checkValue(Parameter parameter);
    void updateSemester(Parameter parameter);
    void updateSyear(Parameter parameter);
    String getParameterValue();
    String getParameterYearValue();
    Boolean checkMac() throws Exception;
}
