<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/31
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学生姓名
                            </div>
                            <div class="col-md-2">
                                <input id="stname" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                身份证号
                            </div>
                            <div class="col-md-2">
                                <input id="idcard" type="text"    class="validate[required,minSize[5],maxSize[10]] form-control"/>
                            </div>
                            <div class="col-md-2" >
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content">
                        <div class="form-row block" style="overflow-y: auto;">
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        学生姓名
                                    </div>
                                    <div class="col-md-4">
                                        <input id="nameShow" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        性别
                                    </div>
                                    <div class="col-md-4">
                                        <input id="sex" type="text"/>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar" id="idcardAlert">
                                        身份证号
                                    </div>
                                    <div class="col-md-4">
                                        <input id="idcardShow" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        出生日期
                                    </div>
                                    <div class="col-md-4">
                                        <input id="birth" type="date" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        入学年份
                                    </div>
                                    <div class="col-md-4">
                                        <input id="joinY" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        入学月份
                                    </div>
                                    <div class="col-md-4">
                                        <input id="joinM" type="text"/>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar" id="enrollmentNumberAlert">
                                        学籍号
                                    </div>
                                    <div class="col-md-4">
                                        <input id="studentNumber" type="text" />
                                    </div>
                                    <div class="col-md-2 tar">
                                        学籍状态
                                    </div>
                                    <div class="col-md-4" id="studentStatusDIV">
                                        <input id="studentStatus" type="text"/>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        民族
                                    </div>
                                    <div class="col-md-4">
                                        <input id="nation" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        政治面貌
                                    </div>
                                    <div class="col-md-4">
                                        <input id="politicalStatus" type="text"/>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        户籍省
                                    </div>
                                    <div class="col-md-4">
                                        <input id="houseProvince" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        户籍市
                                    </div>
                                    <div class="col-md-4">
                                        <input id="houseCity" type="text"/>
                                    </div>

                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        户籍县
                                    </div>
                                    <div class="col-md-4">
                                        <input id="houseCounty" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        户籍详细地址
                                    </div>
                                    <div class="col-md-4">
                                        <input id="housePlace" type="text" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        系部
                                    </div>
                                    <div class="col-md-4">
                                        <input id="hiddenDid" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        专业
                                    </div>
                                    <div class="col-md-4">
                                        <input id="hiddenMid" type="text"/>
                                    </div>

                                </div>

                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        班级
                                    </div>
                                    <div class="col-md-4">
                                        <input id="hiddenCid" type="text"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        手机
                                    </div>
                                    <div class="col-md-4">
                                        <input id="tel" type="text"
                                               class="validate[required,maxSize[20]] form-control"/>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 tar">
                                        家庭电话
                                    </div>
                                    <div class="col-md-4">
                                        <input id="homePhone" type="text"
                                               class="validate[required,maxSize[20]] form-control"/>
                                    </div>
                                    <div class="col-md-2 tar">
                                        备注
                                    </div>
                                    <div class="col-md-4">
                                        <input id="remark" type="text"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function search() {
        var name=$("#stname").val();
        var idcard=$("#idcard").val();
        $.post(<%=request.getContextPath()%>"/enrollment/studentDetailsResult",{
            idcard:idcard,
            name:name
        }, function (data) {
            $("#nameShow").val(data.enrollment.name);
            $("#sex").val(data.enrollment.sex);
            $("#idcardShow").val(data.enrollment.idcard);
            $("#birth").val(data.enrollment.birthday);
            $("#joinY").val(data.enrollment.joinYear);
            $("#joinM").val(data.enrollment.joinMonth);
            $("#studentNumber").val(data.enrollment.studentNumber);
            $("#studentStatus").val(data.enrollment.studentStatusShow);
            $("#nation").val(data.enrollment.nationShow);
            $("#politicalStatus").val(data.enrollment.politicalStatusShow);
            $("#houseProvince").val(data.enrollment.houseProvince);
            $("#houseCity").val(data.enrollment.houseCity);
            $("#houseCounty").val(data.enrollment.houseCounty);
            $("#housePlace").val(data.enrollment.housePlace);
            $("#hiddenDid").val(data.enrollment.departmentShow);
            $("#hiddenMid").val(data.enrollment.majorShow);
            $("#hiddenCid").val(data.enrollment.classShow);
            $("#tel").val(data.enrollment.tel);
            $("#homePhone").val(data.enrollment.homePhone);
            $("#remark").val(data.enrollment.remark);
        });
    }
</script>
